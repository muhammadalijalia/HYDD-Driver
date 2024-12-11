//
//  ClientModel.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 08/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

enum StatusTypes {
    case pending, confirm, inProgress, waitingClient, onBoardClient, dayCompleted, close, cancel
}

class ClientModel: Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var pickupLocation: String = ""
    @objc dynamic var pickLat: Double = 0.0
    @objc dynamic var pickLong: Double = 0.0
    @objc dynamic var destinationLocation: String = ""
    @objc dynamic var destLat: Double = 0.0
    @objc dynamic var destLong: Double = 0.0
    @objc dynamic var pickupDateTime: Int = 0
    @objc dynamic var endMissionDateTime: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var totalFare: Double = 0.0
    @objc dynamic var userId: Int = 0
    @objc dynamic var package: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var missionId: Int = 0
    @objc dynamic var userImage: String = ""
    @objc dynamic var orderName: String = ""
    @objc dynamic var total_km: Int = 0
    @objc dynamic var total_hours: Int = 0
    @objc dynamic var rem_km: NSString = "0"
    @objc dynamic var rem_sec: NSString = "0"
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["mission"]
        pickupLocation <- map["pickup_location"]
        pickLat <- map["pick_lat"]
        pickLong <- map["pick_long"]
        destinationLocation <- map["destination_location"]
        destLat <- map["dest_lat"]
        destLong <- map["dest_long"]
        pickupDateTime <- map["pickup_date_time"]
        endMissionDateTime <- map["end_mission_date_time"]
        status <- map["status"]
        totalFare <- map["total_fare"]
        userId <- map["user_id"]
        package <- map["package"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        missionId <- map["id"]
        userImage <- map["user_image"]
        orderName <- map["order"]
        userImage <- map["total_km"]
        total_hours <- map["total_hours"]
        rem_km <- map["rem_km"]
        rem_sec <- map["rem_secs"]
    }
}
