//
//  AppConstants.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

enum AppEnviroment: String {
    case live = "LIVE"
}
enum AppLang {
    case en, ar
}

let appEnviroment: AppEnviroment = AppEnviroment.live

var appLang: AppLang?
// MARK: Print Function to print all App Prints From one Place
func printHydd(_ any: Any) {
    print(any)
}

func GETSCHEMAVERSION() -> UInt64 {
    return UInt64(1)
}

struct APPCONSTANT {
    struct GENERAL {
        static var GOOGLEPLACEAPIKEY = "AIzaSyACH83VRcOyKZXQaUWEAd6rzBt1RGWQqwc"
        static var userFCMToken = ""
    }

    struct NOTIFICATIONS {
        static let updateCar = Notification.Name("updateCar")
    }
    
    struct Chats {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
        static let storageRoot = Storage.storage().reference()
        static let storageChat = storageRoot.child("chats")
    }
    
    struct LocationMonitor {
        static let updateLocation = 10
    }
}


func GETHEIGHT(_ size: Float) -> CGFloat {
    switch Display.typeIsLike {
    case .iphoneX,
       .iphoneXR:
        return CGFloat(size * 1.2)
    case .iphone5:
        return CGFloat(size * 0.8)
    case .ipadpro12,
       .ipadpro11,
       .ipadPro:
        return CGFloat(size * 1.5)
    case .ipadmini,
       .ipad:
        return CGFloat(size * 1.2)
    default:
        return CGFloat(size)
    }
}

func GETFONTSIZE(_ size: Float) -> CGFloat {
    switch Display.typeIsLike {
    case .iphone5:
        return CGFloat(size * 0.6)
    case .iphone7:
        return CGFloat(size * 0.8)
    default:
        return CGFloat(size)
    }
}

struct PlatformUtils {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}
