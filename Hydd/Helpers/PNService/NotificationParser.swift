//
//  NotificationParser.swift
//  Hydd
//
//  Created Macbook Pro on 21/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.

import Foundation
import NotificationCenter
import UserNotificationsUI
import SwiftyJSON

class NotificationParser {
    
    static let shared = NotificationParser()
    
    private init() { }
    
    func handleNotification(_ userInfo: [AnyHashable: Any]) -> DeeplinkType? {
        
        print("User Info handleNotification \(userInfo)")
        
        let jsonUserInfo = JSON(userInfo)
        
        guard let payload = userInfo as? [String: Any],
            let type = payload["tag_id"] as? String,
            let notificationType = NotificationType(rawValue: type)
            else { return nil }
        
        switch notificationType {
        case .mission_registered:
            let missionId = jsonUserInfo["mission_id"].intValue
            return .missionRegistered(missionId: missionId)
        case .mission_ending,
             .mission_accepted,
             .driver_onway,
             .day_completed,
             .mission_completed,
             .client_onboard,
             .driver_waiting,
             .location_changed,
             .client_cancelled,
             .driver_cancelled:
            return nil
        case .chat_pn:
            let clientId = jsonUserInfo["user_id"].intValue
            let clientName = jsonUserInfo["client_name"].stringValue
            let clientImage = jsonUserInfo["client_image"].stringValue
            return .chatMessage(clientId: clientId, clientName: clientName, clientImage: clientImage)
        }
    }
}
