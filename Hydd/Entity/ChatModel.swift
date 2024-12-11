//
//  ChatModel.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 20/04/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import ObjectMapper

struct ChatModel: Mappable {
    
    var isDriver: Int = 0
    var message: String = ""
    var isMap: Int = 0
    var timestamp: Double = 0
    var lat: Double = 0
    var long: Double = 0
    var userImage: String = ""
    var userId: Int = 0
    var userName: String = ""
    var isAudio: Int = 0
    var audioURL: String = ""
    var isActive: Int = 1
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        isDriver <- map["is_driver"]
        message <- map["message"]
        isMap <- map["is_map"]
        timestamp <- map["timestamp"]
        lat <- map["lat"]
        long <- map["lng"]
        userImage <- map["userImage"]
        userId <- map["userId"]
        userName <- map["userName"]
        isAudio <- map["is_audio"]
        audioURL <- map["audio_url"]
        isActive <- map["is_active"]
    }
}
