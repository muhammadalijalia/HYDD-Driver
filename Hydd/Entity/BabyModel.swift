//
//  BabyModel.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 14/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import ObjectMapper

struct BabyModel: Mappable {
    
    var id: Int = 0
    var seats: Int = 0
    var weight: String = ""
    var age: String = ""
    
    init?(map: Map) {
        
    }
    
    init() {
    }
    
    mutating func mapping(map: Map) {
        id <- map["baby_id"]
        seats <- map["seat"]
        weight <- map["weight"]
        age <- map["age"]
    }
}
