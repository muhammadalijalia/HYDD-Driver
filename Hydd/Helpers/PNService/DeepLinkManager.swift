//
//  DeepLinkManager.swift
//  Hydd
//
//  Created Macbook Pro on 21/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.

import Foundation
import UIKit

let Deeplinker = DeepLinkManager()
class DeepLinkManager {
    
    fileprivate init() { }
    
    private var deeplinkType: DeeplinkType?
    
    func handleRemoteNotification(_ notification: [AnyHashable: Any]) {
        deeplinkType = NotificationParser.shared.handleNotification(notification)
    }
    
    @discardableResult
    func handleDeeplink(url: URL) -> Bool {
        deeplinkType = DeeplinkParser.shared.parseDeepLink(url)
        return deeplinkType != nil
    }
    
    // check existing deepling and perform action
    func checkDeepLink() {
        
        guard let deeplinkType = deeplinkType else {
            return
        }
        
        DeeplinkNavigator.shared.proceedToDeeplink(deeplinkType)
        clearLinkType()
    }
    
    func clearLinkType() {
        self.deeplinkType = nil
    }
    
    func hasDeepLinkType() -> Bool {
        if self.deeplinkType == nil {
            return false
        } else {
            return true
        }
    }
}
