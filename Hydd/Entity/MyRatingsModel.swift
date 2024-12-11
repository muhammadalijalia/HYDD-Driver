//
//  MyRatingsModel.swift
//  HYDD-driver
//
//  Created by MacBook Pro  on 28/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
import Foundation
import ObjectMapper

struct MyRatingsModel: Mappable {
    var driverid: Int = 0
    var firstname: String = ""
    var lastname: String = ""
    var driverImage: String = ""
    var ratingscount: Int = 0
    var averageRating: Double = 0.0
    var communication: Int = 0
    var courtesy: Int = 0
    var punctuality: Int = 0


init?(map: Map) {
       
   }
   
   mutating func mapping(map: Map) {
    driverid <- map["driver"]
    firstname <- map["first_name"]
    lastname <- map["last_name"]
    driverImage <- map["user_image"]
    ratingscount <- map["ratings"]
    averageRating <- map["rating"]
    communication <- map["communication"]
    courtesy <- map["courtesy"]
    punctuality <- map["punctuality"]
   }

}
