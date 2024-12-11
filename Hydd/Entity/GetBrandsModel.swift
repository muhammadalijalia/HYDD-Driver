//
//  GetBrandsModel.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 06/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import ObjectMapper

struct BrandsModel: Mappable {
    
    var id: Int = 0
    var name: String = ""
    var model: [ModelCar] = [ModelCar]()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        model <- map["model"]
    }
}

struct ModelCar: Mappable {
    var id: Int = 0
    var name: String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["model"]
    }
}
