//
//  EarningModel.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 15/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import ObjectMapper

struct Earning: Mappable {
    
    var day: [EarningSummary] = [EarningSummary]()
    var week: [EarningSummary] = [EarningSummary]()
    var month: [EarningSummary] = [EarningSummary]()

    init?(map: Map) {
    }
    
    init(day: [EarningSummary], week: [EarningSummary], month: [EarningSummary]) {
        self.day = day
        self.month = month
        self.week = week
    }
    
    mutating func mapping(map: Map) {
        day <- map["days"]
        week <- map["weeks"]
        month <- map["months"]
        
    }
    
}

struct EarningSummary: Mappable {
    
    var time: String = ""
    var earning: Double = 0.0
    var mission: Int = 0
    var transfer: Int = 0
    var dedicated: Int = 0
    
    init?(map: Map) {
    }
    
    init(time: String = "", earning: Double = 0.0, mission: Int = 0, transfer: Int = 0, dedicated: Int = 0) {
        self.time = time
        self.earning = earning
        self.mission = mission
        self.transfer = transfer
        self.dedicated = dedicated
        
    }
    mutating func mapping(map: Map) {
        time <- map["period"]
        mission <- map["mission"]
        earning <- map["earning"]
        transfer <- map["transfer"]
        dedicated <- map["dedicated"]
    }
}
