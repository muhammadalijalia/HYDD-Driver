//
//  BookingSummaryModel.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 21/05/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import ObjectMapper

struct CarSummaryModel: Mappable {
    
    var id: Int = 0
    var userId: Int = 0
    var packageId: Int = 0
    var orderName: String = ""
    var brand: String = ""
    var category: String = ""
    var modelName: String = ""
    var pickupLocation: String = ""
    var pickupDateTimestamp: Int = 0
    var endDateTimestamp: Int = 0
    var hour: Int = 0
    var km: Double = 0.0
    var destinationLocation: String = ""
    var destinationDate: String = "NA"
    var modelImageServer: String = ""
    var carImage: String = ""
    var farePerKm: Double = 0.0
    var totalFare: Double = 0.0
    var pickLat: Double = 0.0
    var pickLong: Double = 0.0
    var destLat: Double = 0.0
    var destLong: Double = 0.0
    var status: String = ""
    var userFname: String = ""
    var userLname: String = ""
    var userImage: String = ""
    var flightNumber: String = ""
    var trainNumber: String = ""
    var instructions: String = ""
    var nameBoard: String = ""
    var babySeats: [BabyModel] = [BabyModel]()
    var total_hours: Int = 0
    var total_km: Double = 0.0
    var rem_km: Int = 0
    var rem_sec: Int = 0
    var eta: String = ""
    init?(map: Map) {
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        userId <- map["user_id"]
        packageId <- map["package_id"]
        orderName <- map["order"]
        brand <- map["brand"]
        category <- map["category"]
        modelName <- map["model_name"]
        pickupLocation <- map["pickup"]
        pickupDateTimestamp <- map["pickup_date_time"]
        endDateTimestamp <- map["end_mission_date_time"]
        km <- map["km"]
        hour <- map["hours"]
        destinationLocation <- map["destination"]
        destinationDate <- map["end_date"]
        farePerKm <- map["fare_per_km"]
        modelImageServer <- map["model_image"]
        carImage = "https://staging.hydd.caansoft.com/media/\(modelImageServer)"
        pickLat <- map["pick_lat"]
        pickLong <- map["pick_long"]
        destLat <- map["dest_lat"]
        destLong <- map["dest_long"]
        status <- map["status"]
        totalFare <- map["total_fare"]
        userFname <- map["first_name"]
        userLname <- map["last_name"]
        userImage <- map["user_image"]
        flightNumber <- map["flight_number"]
        trainNumber <- map["train_number"]
        instructions <- map["instructions"]
        babySeats <- map["baby_seats"]
        nameBoard <- map["name_board"]
        total_hours <- map["total_hours"]
        total_km <- map["total_km"]
        rem_sec <- map["rem_secs"]
        rem_km <- map["rem_km"]
        eta <- map["eta"]
    }
}
