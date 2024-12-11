//
//  Date.swift
//  Sippy
//
//  Created by Syed Kashan on 12/3/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    static var currentTimeStamp: Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    func dayStringOfWeek() -> String? {
        let id = Calendar.current.dateComponents([.weekday], from: self).weekday
        switch id {
        case 1:
            return "sunday"
        case 2:
            return "monday"
        case 3:
            return "tuesday"
        case 4:
            return "wednesday"
        case 5:
            return "thursday"
        case 6:
            return "friday"
        case 7:
            return "saturday"
        default:
            return ""
        }
    }
    func getSeconds() -> Int {
        let calendar1 = Calendar.current
        let components = calendar1.dateComponents([.second], from: self, to: Date())
        return components.second ?? 0
    }
}

