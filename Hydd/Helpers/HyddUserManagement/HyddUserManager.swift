//
//  HyddUserManager.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 23/03/2020.
//  Copyright (c) 2020 Syed Kashan. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject
//import Realm

protocol IHyddUserManager: class 	{
    // do someting...
    func isUserLogedIn() -> Bool
    func SetUser(set: User)
    func SetUserLogedOUT()
}
typealias HUM = HyddUserManager

class HyddUserManager: IHyddUserManager {
    
    var user: User?
    var driverRating: MyRatingsModel?
    
    init() {
        if UserDefaults.standard.isUserLogedIn ?? false {
            if let user = try? RDBM.shared.getAll(with: User.self).last {
                self.user = user
            } else {
                UserDefaults.standard.isUserLogedIn = false
            }
        }
    }
    
    static let shared = HyddUserManager()
    static let apiClient = APIClient()
    
    var tokenTask: URLSessionDataTask!
    var getProfileTask: URLSessionDataTask!
    var editProfileTask: URLSessionDataTask!
    var getRatingTask: URLSessionDataTask!
    
    
    func getToken(completionHandler: @escaping (Bool) -> Void) {
        tokenTask?.cancel()
        let para = ["username": "hydd_@gmail.com",
                    "password": "hyddqwerty"]
        let token = URLRequest(url: NETWORKCONSTANTS.META.getToken,
                               method: URLRequest.HTTPMethod.post,
                               body: para)
        tokenTask = HUM.apiClient.dataTask(token) { response in
            response.successResponse.flatMap { (data, response) in
                printHydd("Response is \(data) \nResponse \(response)")
                printHydd(String(decoding: data, as: UTF8.self))
                if let dataDictionary = data.getJSONFromData() {
                    if let token = dataDictionary["access_token"] as? String {
                        UserDefaults.standard.set(token, forKey: "authenticationToken")
                        completionHandler(true)
                    } else {
                        completionHandler(false)
                    }
                } else {
                    completionHandler(false)
                }
            }
        }
    }
    func getProfile(id: Int, completionHandler: @escaping (Bool) -> Void) {
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.getProfileTask?.cancel()
                let url = NETWORKCONSTANTS.getProfile(id: id)
                let profile = URLRequest(url: url,
                                         method: URLRequest.HTTPMethod.get,
                                         body: nil)
                self.getProfileTask = HUM.apiClient.dataTask(profile) { response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                HMM.shared.showError(title: "Uh oh!", message: message)
                                completionHandler(false)
                            } else {
                                if let data = dataDictionary["data"] as? [String: Any] {
                                    if let user = User(JSON: data) {
                                        user.id = id
                                        self.SetUser(set: user)
                                        HCM.shared.getCars(id: id) { (_) in}
                                        completionHandler(true)
                                    } else {
                                        HMM.shared.showError(title: "Uh oh!", message: "Something went wrong")
                                        completionHandler(false)
                                    }
                                }
                            }
                        } else {
                            completionHandler(false)
                        }
                    }
                }
            }
        }
    }
    func editProfile(para: [String: Any], completionHandler: @escaping (Bool, String) -> Void) {
        guard let id = self.user?.id else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.editProfileTask?.cancel()
                let profile = URLRequest(url: NETWORKCONSTANTS.editProfile(id: id),
                                         method: URLRequest.HTTPMethod.patch,
                                         body: para)
                self.editProfileTask = HUM.apiClient.dataTask(profile) { response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let _ = dataDictionary["message"] as? String {
                                self.handleValidateSignup(dataDictionary: dataDictionary) { (errors) in
                                    completionHandler(false, errors[0])
                                }
                            } else {
                                if let data = dataDictionary["data"] as? [String: Any] {
                                    if let user = User(JSON: data) {
                                        user.id = id
                                        self.SetUser(set: user)
                                        HCM.shared.getCars(id: id) { (_) in}
                                        completionHandler(true, "")
                                    } else {
                                        completionHandler(false, "Something went wrong")
                                    }
                                }
                            }
                        } else {
                            completionHandler(false, "Something went wrong")
                        }
                    }
                }
            }
        }
    }
    func isUserLogedIn() -> Bool {
        return UserDefaults.standard.isUserLogedIn ?? false
    }
    func SetUser(set: User) {
        DispatchQueue.main.async {
            UserDefaults.standard.isUserLogedIn = true
            RDBM.shared.Save(item: set)
            self.user = set
        }
    }
    func SetUserLogedOUT() {
        DispatchQueue.main.async {
            UserDefaults.standard.isUserLogedIn = false
            RDBM.shared.deleteALLObject(with: User.self)
            RDBM.shared.deleteALLObject(with: MyCarModel.self)
            printHydd("Deleting User")
            Bootstrapper.makeUserFlow()
        }
    }
    
    func handleValidateSignup(dataDictionary: [String: Any], completionHandler: @escaping([String]) -> Void) {
        DispatchQueue.main.async {
            if let message =  dataDictionary["message"] as? [String: Any] {
                var arrayErrors = [String]()
                
                if let email = message["email"] as? [String],
                    let error = email.first {
                    arrayErrors.append(error)
                }
                
                if let username = message["username"] as? [String],
                    let error = username.first {
                    arrayErrors.append(error)
                }
                
                if let password = message["password"] as? [String],
                    let error = password.first {
                    arrayErrors.append(error)
                }
                
                if let phoneNumber = message["phone_number"] as? [String],
                    let error = phoneNumber.first {
                    arrayErrors.append(error)
                }
                
                if let image = message["user_image"] as? [String],
                    let error = image.first {
                    arrayErrors.append(error)
                }
                if let address = message["address"] as? [String],
                    let error = address.first {
                    arrayErrors.append(error)
                }
                completionHandler( arrayErrors)
            } else {
                completionHandler(["Validation Error"])
            }
        }
    }
    
    func driverRating(completionHandler: @escaping (Bool, String) -> Void){
        guard let id = self.user?.id else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.getRatingTask?.cancel()
                let url = NETWORKCONSTANTS.myRatings(id: id)
                let Rating = URLRequest(url: url,
                                        method: URLRequest.HTTPMethod.get,
                                        body: nil)
                self.getRatingTask = HUM.apiClient.dataTask(Rating) { response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                completionHandler(false, message)
                            } else {
                                if let data = dataDictionary["data"] as? [[String:Any]] {
                                    if let myRating = MyRatingsModel(JSON: data[0])   {
                                        self.driverRating = myRating
                                        completionHandler(true, "")
                                    }
                                } else {
                                    completionHandler(false, "Something went wrong!")
                                }
                            }
                        } else {
                            completionHandler(false, "Something went wrong!")
                        }
                    }
                }
            }
        }
    }
}
