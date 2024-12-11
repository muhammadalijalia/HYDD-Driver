//
//  GooglePlacePicker.swift
//  Big Blue People

import UIKit
import GooglePlaces
import SwiftyJSON
import GoogleMaps

struct AddressStrKey {
    static let address  = "address"
    static let city     = "city"
    static let state    = "state"
    static let lat      = "lat"
    static let long     = "lng"
    static let area     = "area"
    static let country  = "country"
    static let pincode  = "pincode"
    static let countrySortName = "countrySortName"
    
}

public enum GoogleResults: String {
    
    case Building       = "premise"
    case Street         = "street_number"
    case Route          = "route"
    case Sub_Area       = "sublocality_level_2"
    case Area           = "sublocality_level_1"
    case City           = "locality"
    case Locality       = "administrative_area_level_2"
    case State          = "administrative_area_level_1"
    case Country        = "country"
    case Postal_Code    = "postal_code"
}

class GooglePlacePicker: NSObject, GMSAutocompleteViewControllerDelegate {
    
    static let shared: GooglePlacePicker = GooglePlacePicker()
    static let apiClient = APIClient()
    static var placesTask: URLSessionDataTask!
    static var routesTask: URLSessionDataTask!
    
    var completion : ((_ data: JSON) -> Void)?
    
    func openPlacePicker(_ searchText: String = "") {
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        let placePicker = GMSAutocompleteViewController()
        placePicker.autocompleteFilter = filter
        let (lat, long) = HLM.shared.getForLatLong()
        placePicker.autocompleteBounds = GMSCoordinateBounds().includingCoordinate(CLLocationCoordinate2D(latitude: lat,longitude: long))
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
        
        let topVC = UIViewController.top()
            placePicker.popoverPresentationController?.sourceView = topVC.view
            placePicker.popoverPresentationController?.sourceRect = topVC.view.bounds
            topVC.present(placePicker, animated: true) {
                if let searchBar = (placePicker.view.subviews
                    .flatMap { $0.subviews }
                    .flatMap { $0.subviews }
                    .flatMap { $0.subviews }
                    .filter { $0 == $0 as? UISearchBar}).first as? UISearchBar {
                    searchBar.text = searchText
                    searchBar.delegate?.searchBar?(searchBar, textDidChange: searchText)
                }
            }
        
    }
    
    // MARK: - Google Place Picker delegate
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        if let address: String = place.formattedAddress {
            
            var json = JSON()
            json[AddressStrKey.address].stringValue = address
            //json[AddressStrKey.lat].stringValue = String(format: "%.4f", place.coordinate.latitude)
            //json[AddressStrKey.long].stringValue = String(format: "%.4f", place.coordinate.longitude)
            
            json[AddressStrKey.lat].stringValue = String(place.coordinate.latitude)
            json[AddressStrKey.long].stringValue = String(place.coordinate.longitude)
            
            // Get address component
            if let component = place.addressComponents {
                
                let city = component.filter {($0.types.isEmpty ? "": $0.types[0]) == GoogleResults.City.rawValue}
                json[AddressStrKey.city].stringValue = city.count > 0 ? city.first!.name : ""
                
                //let postalCode = place.addressComponents!.filter{$0.type == APIResponseKey.kPostalCode.rawValue }
                
                //json[APIResponseKey.kPostalCode.rawValue].stringValue = postalCode.count > 0 ? postalCode.first!.name : ""
            }
            
            //completion!(json)
            if self.completion != nil {
                self.completion!(json)
            }
            viewController.dismiss(animated: true, completion: nil)
            viewController.delegate = nil
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("An error occurred while picking a place: \(error)")
        viewController.delegate = nil
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("The place picker was canceled by the user")
        viewController.dismiss(animated: true, completion: nil)
        viewController.delegate = nil
    }
    
    static func getAddressFromLatLong(lat: Double,
                                      lng: Double,
                                      completionHandler: @escaping ( _ fullAddress: [[String: Any]] ) -> Void) {
    let geocoder = GMSGeocoder()
    var location: CLLocationCoordinate2D?
    location = CLLocationCoordinate2D.init(latitude: lat, longitude: lng)
    if let loc = location {
        geocoder.reverseGeocodeCoordinate(loc, completionHandler: { (response, error) in
            guard error == nil else {
                debugPrint(error!)
                return }
            if let res = response?.results() {
                var dictionary: [[String: Any]] = [[:]]
                for address in res {
                    if address.locality != nil {
                        var dict: [String: Any] = [:]
                        dict[AddressStrKey.lat] = JSON(lat).doubleValue
                        dict[AddressStrKey.long] = JSON(lng).doubleValue
                        if let addresses = address.lines, let adres = addresses.first {
                            dict[AddressStrKey.address] = adres
                        }
                        if let area = address.subLocality {
                            dict[AddressStrKey.area] = area
                        }
                        if let city = address.locality {
                            dict[AddressStrKey.city] = city
                        }
                        if let state = address.administrativeArea {
                            dict[AddressStrKey.state] = state
                        }
                        if let country = address.country {
                            dict[AddressStrKey.country] = country
                        }
                        if let postalcode = address.postalCode {
                            dict[AddressStrKey.pincode] = postalcode
                        }
                        dictionary.append(dict)
                    }
                }
                completionHandler(dictionary)
                return
            }
            debugPrint("not found")
        })
    }
}
    static func getRoutes(source: CLLocation,
                        destination: CLLocation,
                        completionHandler: @escaping(String) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.coordinate.latitude),\(source.coordinate.longitude)&destination=\(destination.coordinate.latitude),\(destination.coordinate.longitude)&sensor=false&mode=driving&key=\(APPCONSTANT.GENERAL.GOOGLEPLACEAPIKEY)"
        guard let url = URL(string: urlString) else {
            return
        }
        if let task = routesTask, task.taskIdentifier > 0 && task.state == .running {
            task.cancel()
        }

        routesTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                debugPrint(error!)
                return }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
                print("error in JSONSerialization")
                return
            }
            
            guard let routes = jsonResult["routes"] as? [Any] else {
                return
            }
            
            if routes.count > 0 {
                guard let route = routes[0] as? [String: Any] else {
                    return
                }
                
                guard let legs = route["legs"] as? [[String: Any]] else {
                    return
                }
                
                guard let distance = legs[0]["distance"] as? [String: Any] else {
                    return
                }

                guard let distanceValue = distance["value"] as? Double else {
                    return
                }
                printHydd(distanceValue)

                guard let overview_polyline = route["overview_polyline"] as? [String: Any] else {
                    return
                }

                guard let polyLineString = overview_polyline["points"] as? String else {
                    return
                }
                completionHandler(polyLineString)
            }
        }
        routesTask.resume()
    }
//    static func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D,
//                                          radius: Double,
//                                          types: [String] = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant", "store", "department_store"], completionHandler: @escaping ( _ fullAddress: [GooglePlace]) -> Void) {
//        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&rankby=distance&sensor=true&key=\(APPCONSTANT.GENERAL.GOOGLEPLACEAPIKEY)"
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        if let task = placesTask, task.taskIdentifier > 0 && task.state == .running {
//            task.cancel()
//        }
//
//        DispatchQueue.main.async {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        }
//
//        placesTask = URLSession.shared.dataTask(with: url) { data, _, error in
//            guard error == nil else {
//                debugPrint(error!)
//                return }
//           var placesArray: [GooglePlace] = []
//            guard let data = data,
//              let json = try? JSON(data: data, options: .mutableContainers),
//              let results = json["results"].arrayObject as? [[String: Any]] else {
//                return
//            }
//            print(results)
//            results.forEach {
//              let place = GooglePlace(dictionary: $0, acceptedTypes: types)
//              placesArray.append(place)
//            }
//            completionHandler(placesArray)
//        }
//        placesTask?.resume()
//    }
}
