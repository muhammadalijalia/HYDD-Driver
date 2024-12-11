//
//  Int+Extention.swift
//  Sippy
//
//  Created by Syed Kashan on 10/16/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

extension Int {

    var boolValue: Bool {
        return self != 0
    }
    
    enum Status {
        case success, validation, authentication, failure, upgrade, unknown
    }
    
    var status: Status {
        switch self {
        case 200...299:
            return .success
        case 422:
            return .validation
        case 401:
            return .authentication
        case 400...499:
            return .failure
        case 505:
            return .upgrade
        default:
            return .unknown
        }
    }
}
