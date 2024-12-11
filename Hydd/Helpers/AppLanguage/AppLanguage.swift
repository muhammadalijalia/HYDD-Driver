//
//  AppLanguage.swift
//  Sippy
//
//  Created by Syed Kashan on 8/27/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class AppLanguage {
    
    class var selectedLanguage: String? {
        if let selectedLanguage = UserDefaults.selectedLanguage {
            return selectedLanguage
        }
        return nil
    }
    
    class func set(selectedLanguage: String) {
        UserDefaults.set(selectedLanguage: selectedLanguage)
    }
    
    /// get current Apple language
    class func currentAppleLanguage() -> String? {
        let userdef = UserDefaults.standard
        if let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as? NSArray,
            let current = langArray.firstObject as? String {
            
            let start = current.index(current.startIndex, offsetBy: 0)
            let end = current.index(current.startIndex, offsetBy: 2)
            let range = start..<end
            let currentWithoutLocale = current[range]  // en
            return String(currentWithoutLocale)
        }
        return nil
    }
    
    class func currentAppleLanguageFull() -> String? {
        let userdef = UserDefaults.standard
        if let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as? NSArray,
            let current = langArray.firstObject as? String {
            if let language = UserDefaults.selectedLanguage {
                return language
            }
            return current
        }
        return nil
    }
    
    class var isRTL: Bool {
        return AppLanguage.currentAppleLanguage() == "ar"
    }
}
