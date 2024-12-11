//
//  Bundle.swift
//  HyddDriver
//
//  Created by Kashan on 24/03/2020.
//  Copyright © 2020 Shahzaib Iqbal Bhatti. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    // MARK: Bundle Localization
    
    func getBundleName() -> Bundle {
        
        func returnBase() -> Bundle {
            let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
            let bundle = Bundle(path: path!)
            return bundle!
        }
        
        if let languageArray = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
            
            switch languageArray[0] {
                
            case "en":
                if let path = Bundle.main.path(forResource: languageArray[0], ofType: "lproj") {
                    let bundle = Bundle(path: path)
                    return bundle!
                } else {
                    return returnBase()
                }
                
            default:
                if let path = Bundle.main.path(forResource: languageArray[0], ofType: "lproj") {
                    let bundle = Bundle(path: path)
                    return bundle!
                } else {
                    return returnBase()
                }
                
            }
            
        } else {
            return returnBase()
        }
        
    }
}
