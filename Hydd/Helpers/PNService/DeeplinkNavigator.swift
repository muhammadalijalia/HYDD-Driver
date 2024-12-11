//
//  DeeplinkNavigator.swift
//  Hydd
//
//  Created Macbook Pro on 21/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.

import Foundation
import UIKit

class DeeplinkNavigator {
    
    static let shared = DeeplinkNavigator()
    
    private init() { }
    
    deinit { print("deinit singleton") }
    
    func proceedToDeeplink(_ type: DeeplinkType) {
        switch type {
        case .missionRegistered(let missionId):
            missionRegistered(missionId)
        case .chatMessage(let clientId, let clientName, let clientImage):
            chatMessage(clientId: clientId, clientName: clientName, clientImage: clientImage)
        }
    }
}

extension DeeplinkNavigator {
    
    func missionRegistered(_ missionId: Int) {
        HDCM.shared.getMissionData(missionId: missionId) { (isSuccess, data) in
            DispatchQueue.main.async {
                if isSuccess {
                    if (UIViewController.top() as? HyddTabbarVC) != nil {
                        Bootstrapper.showMissionDetail(data: data)
                    } else {
                        Bootstrapper.showTabbar(selectedIndex: 0)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                            Bootstrapper.showMissionDetail(data: data)
                        }
                    }
                } else {
                    Bootstrapper.showTabbar(selectedIndex: 0)
                }
            }
        }
    }
    
    func chatMessage(clientId: Int, clientName: String, clientImage: String) {
        if (UIViewController.top() as? HyddTabbarVC) != nil {
            Bootstrapper.showChatScreen(clientId: clientId, clientName: clientName, clientImage: clientImage)
        } else {
            Bootstrapper.showTabbar(selectedIndex: 0)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                Bootstrapper.showChatScreen(clientId: clientId, clientName: clientName, clientImage: clientImage)
            }
        }
    }
}
