//
//  AppDelegate.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 18/01/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import GoogleMaps
import GooglePlaces
@_exported import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var deviceTokenData = Data()
    var window: UIWindow?
    static let shared = UIApplication.shared.delegate as? AppDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(APPCONSTANT.GENERAL.GOOGLEPLACEAPIKEY)
        GMSPlacesClient.provideAPIKey(APPCONSTANT.GENERAL.GOOGLEPLACEAPIKEY)
        HLM.shared.startServices(delgate: nil)
        setUpIQKeyBoardManager()
        Bootstrapper.initialize(launchOptions)
        handlePushNotification()
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        return true
    }
    
    func setUpIQKeyBoardManager() {
        IQKeyboardManager.shared().isEnabled                                        = true
        IQKeyboardManager.shared().isEnableAutoToolbar                              = true
        IQKeyboardManager.shared().keyboardDistanceFromTextField                    = 5
        IQKeyboardManager.shared().shouldResignOnTouchOutside                       = true
        IQKeyboardManager.shared().toolbarTintColor                                 = .white
        IQKeyboardManager.shared().toolbarBarTintColor                              = .hyddblue
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder                     = false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("didRegister called")
        self.deviceTokenData = deviceToken
        self.storeDeviceToken()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Device Token Not Found \(error)")
    }
    
    func storeDeviceToken() {
        let deviceTokenString = self.deviceTokenData.reduce("", {$0 + String(format: "%02X", $1)})
        UserDefaults.standard.DeviceToken = deviceTokenString
    }
    
    func handlePushNotification() {
        print("Here on the notification")
        if #available(iOS 10.0, *) {
            // SETUP FOR NOTIFICATION FOR iOS >= 10.0
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (_, error) in
                if error == nil {
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()
                        
                    })
                }
            }
        } else {
            // SETUP FOR NOTIFICATION FOR iOS < 10.0
            let settings = UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        printHydd("going applicationDidEnterBackground")
        HLM.shared.startMonitoring()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        printHydd("going applicationWillEnterForeground")
        HLM.shared.startMonitoring()
        HUM.shared.getToken { (_) in}
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        HLM.shared.startMonitoring()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        HLM.shared.startMonitoring()
    }
    
}

