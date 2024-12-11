//
//  Data.swift
//  Sippy
//
//  Created by Syed Kashan on 8/27/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation
extension Data {
    
    public func getJSONFromData() -> [String: Any]? {
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any] {
                return json
            }
            if let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [[String: Any]] {
                return json[0]
            }
        } catch _ as NSError {
            return nil
        }
        return nil
    }
}
