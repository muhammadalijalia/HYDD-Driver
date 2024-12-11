//
//  Userdefualts.swift
//  Sippy
//
//  Created by Syed Kashan on 8/27/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation
extension UserDefaults {
    
    private struct Keys {
        
        // MARK: - Constants
        static let selectedLanguage = "selectedLanguage"
        static let firstTimeUser = "firstTimeUser"
        
    }
    
    // MARK: - Language
    class var selectedLanguage: String? {
        let storedValue = UserDefaults.standard.string(forKey: UserDefaults.Keys.selectedLanguage)
        return storedValue
    }
    
    class func set(selectedLanguage: String) {
        UserDefaults.standard.set(selectedLanguage, forKey: UserDefaults.Keys.selectedLanguage)
    }
    
    // MARK: - FirstTimeUser
    
    class var firstTimeUser: Bool {
        let storedValue = UserDefaults.standard.bool(forKey: UserDefaults.Keys.firstTimeUser)
        return storedValue
    }
    
    class func set(firstTimeUser: Bool) {
        UserDefaults.standard.set(firstTimeUser, forKey: UserDefaults.Keys.firstTimeUser)
    }
    
    var notificationCode: String? {
       get {
           return string(forKey: "notificationCode")
       }
       set {
           set(newValue, forKey: "notificationCode")
           synchronize()
       }
    }
    
    var isUserLogedIn: Bool? {
       get {
           return bool(forKey: "isUserLogedIn")
       }
       set {
           set(newValue, forKey: "isUserLogedIn")
           synchronize()
       }
    }
    var DeviceToken: String? {
       get {
           return string(forKey: "DeviceToken")
       }
       set {
           set(newValue, forKey: "DeviceToken")
           synchronize()
       }
    }
    
    var lastLocationUpdate: Date? {
       get {
        guard let date = object(forKey: "lastLocationUpdate") as? Date else { return Date() }
        return date
       }
       set {
           set(newValue, forKey: "lastLocationUpdate")
           synchronize()
       }
    }
    var lastLatitude: Double? {
       get {
        return double(forKey: "lastLatitude")
       }
       set {
           set(newValue, forKey: "lastLatitude")
           synchronize()
       }
    }
    var lastLongitude: Double? {
       get {
        return double(forKey: "lastLongitude")
       }
       set {
           set(newValue, forKey: "lastLongitude")
           synchronize()
       }
    }
}
