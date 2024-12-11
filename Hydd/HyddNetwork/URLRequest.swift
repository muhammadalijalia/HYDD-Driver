//
//  URLRequest.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation
import UIKit

extension URLRequest {
    
    public init(url: String, method: HTTPMethod, body: [String: Any]?) {
        guard let requestURL = URL(string: url) else { fatalError("URL is not created") }
        
        self.init(url: requestURL)
        self.timeoutInterval = 30.0
        
        self.method = method
        
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.setValue("application/json", forHTTPHeaderField: "Accept")

        self.setValue("ios", forHTTPHeaderField: "x-device-type")

        if let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            let version = "\(shortVersion).\(build)"
            self.setValue(version, forHTTPHeaderField: "x-app-version")
        }

        let systemVersion = UIDevice.current.systemVersion
        self.setValue(systemVersion, forHTTPHeaderField: "x-os-version")

        if let body = body {
            let httpBody: Data
            do {
                httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                self.httpBody = httpBody
            } catch {
                
                return
            }
        }
        
        if let token = UserDefaults.standard.string(forKey: "authenticationToken") {
            if !token.isEmpty {
                print("Token is \(token)")
                self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
    }
}
