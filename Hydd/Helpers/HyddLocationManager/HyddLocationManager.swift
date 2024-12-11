//
//  HyddLocationManager.swift
//  Hydd
//
//  Created by Syed Kashan on 23/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit
import Swinject
import CoreLocation
import GooglePlaces
import GoogleMaps

typealias HLM = HyddLocationManager

protocol IHyddLocationManager: class {
}

protocol HyddLocationProtocol: class {
    func didUpdateLocation(location: CLLocationCoordinate2D)
    func didUpdateLocationVariables()
}
extension HyddLocationProtocol {
    func didUpdateLocationVariables() {}
}

class HyddLocationManager: UIView, IHyddLocationManager {
    static let shared = HyddLocationManager()
    weak var delegate: HyddLocationProtocol?
    
    enum PermissionType {
        case autharized, denied, nottaken
    }
    
    private var permissionType: PermissionType?
    
    var locationManager: CLLocationManager?
    
    var isFirst = true
    var myLastCurrentLocation: CLLocation?
    
    var myOrignalLocation: CLLocation?
    
    var myCurrentLocation: CLLocation?
    var myCurrentArea: String?
    var myCountryCity: String?
    var myCurrentRegion: CLRegion?
    var myCountry: String?
    
    //    var searchedPlaces: [GooglePlacesMapping] = []
    //    var selectedPlace: GooglePlacesMapping?
    var isSelectedPlace = false
    
    let currencySymbol = Locale.current.currencySymbol
    let currencyCode = Locale.current.currencyCode
    
    var latitude: Double?
    var longitude: Double?
    
    let apiClient = APIClient()
    var searchTask: URLSessionDataTask!
    
    init() {
        super.init(frame: CGRect.zero)
        locationManager = CLLocationManager()
        locationManager?.distanceFilter = 10.0
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.delegate = self
        self.permissionType = .nottaken
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        checkAuth()
    }
    
    func getForLatLong() -> (Double, Double) {
        guard let loaction = self.getMyLocation() else { return (0, 0) }
        guard let mySelectedLat = self.latitude, let mySelectedLang = self.longitude else {
            return  (loaction.coordinate.latitude, loaction.coordinate.longitude)}
        return  (mySelectedLat, mySelectedLang)
    }
    func getForCityCountry() -> (String, String) {
        guard let city = self.myCurrentArea else { return ("", self.myCountry ?? "")}
        
        return  (city, self.myCountry ?? "")
    }
    func startServices(delgate: HyddLocationProtocol? = nil) {
        checkAuth()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.desiredAccuracy = 1
            self.locationManager?.startUpdatingLocation()
            self.delegate = delgate
        }
    }
    func startMonitoring() {
        self.locationManager?.startUpdatingLocation()
    }
    func stopMonitoring() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func resetCity() {
        DispatchQueue.main.async {
            guard let location = self.getMyLocation() else { return }
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location) {(placemarks, _ ) in
                guard let currentLocPlacemark = placemarks?.first else { return }
                self.myCurrentArea = currentLocPlacemark.locality ?? currentLocPlacemark.country ?? currentLocPlacemark.isoCountryCode ?? ""
                self.myCountryCity = currentLocPlacemark.country ?? currentLocPlacemark.locality ?? ""
                self.myCurrentRegion = currentLocPlacemark.region
                self.myCountry = currentLocPlacemark.country ?? ""
                print(self.myCurrentArea ?? "", "City is here?")
                self.delegate?.didUpdateLocationVariables()
            }
        }
    }
    
    private func checkAuth() {
        guard let authType = self.permissionType else { return }
        switch authType {
        case .autharized:
            self.locationManager?.startUpdatingLocation()
        case .denied:
            gotoPermissionSetting()
        case .nottaken:
            locationManager?.requestAlwaysAuthorization()
        }
    }
    
    func gotoPermissionSetting() {
        let alert = UIAlertController(title: "Settings", message: "Allow location from settings", preferredStyle: UIAlertController.Style.alert)
        UIViewController.top().present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: { action in
            switch action.style {
            case .default:
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            case .cancel:
                printHydd("cancel")
            case .destructive:
                printHydd("cancel")
            @unknown default:
                printHydd("defult")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
    }
    func getMyLocation() -> CLLocation? {
        checkAuth()
        return myCurrentLocation
    }
    func getDistance(lat: Double, long: Double) -> String {
        let  (mlat, mlong) = HLM.shared.getForLatLong()
        let myLocation2 = CLLocation(latitude: mlat, longitude: mlong)
        let otherLocation = CLLocation(latitude: lat, longitude: long)
        let distance = myLocation2.distance(from: otherLocation)
        return "\((distance / 1000).rounded(toPlaces: 4))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HyddLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            printHydd("User denied location permission") // Bail out of switch statement. Consider showing an alert that your app will need location to work
            permissionType = .denied
            self.gotoPermissionSetting()
        case .authorizedWhenInUse:
            printHydd("App is authorized to use location while in use")
            permissionType = .autharized
        case .authorizedAlways:
            printHydd("App is authorized to always use this device's location")
            permissionType = .autharized
        default:
            printHydd("User has not yet determined location permission")
            permissionType = .nottaken
            self.locationManager?.requestAlwaysAuthorization()
        }
        self.locationManager?.startUpdatingLocation()
    }
    func getMeAllLocationVariables(location: CLLocation ) {
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        geocoder.reverseGeocodeCoordinate(coordinate) { response, _ in
            if let address = response?.firstResult() {
                self.myCurrentArea = address.locality ?? address.country ?? ""
                self.myCountryCity = address.country ?? address.locality ?? ""
                self.myCountry = address.country ?? ""
                self.delegate?.didUpdateLocationVariables()
            }
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            myCurrentLocation = location
            print("My current location is: \(location)")
            delegate?.didUpdateLocation(location: location.coordinate)
            guard let status = HDCM.shared.getStatus(),
                let idDriver = HUM.shared.user?.id,
                let userId = HDCM.shared.clientUserDetails?.userId else {return}
            if status == .inProgress || status == .waitingClient || status == .onBoardClient {
                let para = ["is_driver": 1,
                            "driver_id": idDriver,
                            "lat": location.coordinate.latitude,
                            "lng": location.coordinate.longitude] as [String: Any]
                APPCONSTANT.Chats.databaseRoot.child("location_\(userId)_\(idDriver)").childByAutoId().setValue(para)
                APPCONSTANT.Chats.databaseRoot.child("location_\(userId)_\(idDriver)_currentLocation").setValue(para)

            }
//            if HDCM.shared.isUpdatingKMHours() {
//                let time = UserDefaults.standard.lastLocationUpdate ?? Date()
//                printHydd("time is: \(time.getSeconds())")
//                if time.getSeconds() > APPCONSTANT.LocationMonitor.updateLocation {
//                    let prevCoOrdinates = CLLocation(latitude: UserDefaults.standard.lastLatitude ?? 0.0, longitude: UserDefaults.standard.lastLongitude ?? 0.0)
//                    let distance = location.distance(from: prevCoOrdinates)
//                    let para = ["consumed_hours": time.getSeconds(),
//                                "consumed_kms": Int(distance)] as [String: Any]
//                    printHydd("para is: \(para)")
//                    HDCM.shared.updateConsumedHoursNDistance(para: para) { (success) in
//                        if success {
//                            UserDefaults.standard.lastLocationUpdate = Date()
//                            UserDefaults.standard.lastLatitude = location.coordinate.latitude
//                            UserDefaults.standard.lastLongitude = location.coordinate.longitude
//                        }
//                    }
//                }
//            }
        }
    }
    
    func canUpdateLocation(location: CLLocation) -> Bool {
        let old = location.coordinate.latitude.rounded(toPlaces: 4) + location.coordinate.longitude.rounded(toPlaces: 4)
        let new = (myLastCurrentLocation?.coordinate.latitude.rounded(toPlaces: 4) ?? 0) + (myLastCurrentLocation?.coordinate.longitude.rounded(toPlaces: 4) ?? 0)
        let diff = old - new
        let city = self.myCurrentArea?.count ?? 0
        let country = self.myCountry?.count ?? 0
        if diff > 10 ||  diff < -10 && !isFirst &&  city > 2  && country > 2 {
            return false
        }
        return true
    }
}

extension HyddLocationManager {
    func getPlaceCoordinates(placeId: String, completionHandler: @escaping (Bool, String) -> Void) {
        let googlePlaceApiUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeId)&key=\(APPCONSTANT.GENERAL.GOOGLEPLACEAPIKEY)"
        let urlString = googlePlaceApiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        searchTask?.cancel()
        
        let search = URLRequest(url: urlString,
                                method: URLRequest.HTTPMethod.get,
                                body: nil)
        
        searchTask = self.apiClient.dataTask(search) {  response in
            response.successResponse.flatMap { (data, _) in
                if let searchData = data.getJSONFromData() {
                    if let status = searchData["status"] as? String {
                        switch status.placesStatus {
                        case .success:
                            if let results = searchData["result"] as? [String: Any] {
                                
                                printHydd(results)
                                if let geometry = results["geometry"] as? [String: Any] {
                                    printHydd(geometry)
                                    if let location = geometry["location"] as? [String: Any] {
                                        printHydd(location)
                                        self.latitude = location["lat"] as? Double
                                        self.longitude = location["lng"] as? Double
                                    }
                                }
                            }
                            completionHandler(true, status)
                        case .empty:
                            completionHandler(false, status)
                        case .invalidKey:
                            completionHandler(false, status)
                        case .failure:
                            completionHandler(false, status)
                        case .serverFail:
                            completionHandler(false, status)
                        case .invalid:
                            completionHandler(false, status)
                        }
                    }
                }
            }
        }
    }
    func setAllLocationFeatures(lat: Double?, long: Double?) {
        guard let lat = self.latitude,
            let long = self.longitude else { return }
        let location = CLLocation(latitude: lat, longitude: long)
        printHydd("CALLED BY setAllLocationFeatures")
        self.isFirst = false
        if canUpdateLocation(location: location) {
            return
        } else {
            self.myLastCurrentLocation = location
        }
        getMeAllLocationVariables(location: location)
    }
    func setLatLong(lat: Double?, long: Double?) {
        self.latitude = lat
        self.longitude = long
        self.myLastCurrentLocation = nil
        setAllLocationFeatures(lat: lat, long: long)
    }
}
