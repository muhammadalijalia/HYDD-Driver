//
//  Appdelegate+PN.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 31/05/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import UserNotifications
import Firebase
import FirebaseMessaging

let gcmMessageIDKey = "gcm.message_id"
extension AppDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        guard let logedin = UserDefaults.standard.isUserLogedIn, logedin else { return }
        let userInfo = notification.request.content.userInfo
        printHydd(userInfo)
        if userInfo["tag_id"] as? String == "chat_pn" {
            if let chatVC = UIViewController.isChatViewControllerAtTop(), chatVC.clientId == (userInfo["user_id"] as? NSString)?.integerValue {
                completionHandler([])
            } else {
                completionHandler([.alert, .sound, .badge])
            }
        } else {
            completionHandler([.alert, .sound, .badge])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        Deeplinker.handleRemoteNotification(userInfo)
        if !UserDefaults.standard.bool(forKey: "INITIALIZE") {
            UserDefaults.standard.set(false, forKey: "INITIALIZE")
            Deeplinker.checkDeepLink()
        }
    }
}

extension AppDelegate: MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        APPCONSTANT.GENERAL.userFCMToken = fcmToken!
    }
}
