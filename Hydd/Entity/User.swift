//
//  User.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 23/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class User: Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var fName: String = ""
    @objc dynamic var LName: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var userImage: String = ""
    @objc dynamic var socialSecurityNumber: String = ""
    @objc dynamic var licenseNumber: String = ""
    @objc dynamic var licenseImage: String = ""
    @objc dynamic var companyName: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var plateNumber: String = ""
    @objc dynamic var access: String = "restricted"

    
    var userImageEndPoint = ""

    required convenience public init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        username <- map["username"]
        email <- map["email"]
        fName <- map["first_name"]
        LName <- map["last_name"]
        phoneNumber <- map["phone_number"]
        address <- map["address"]
        userImageEndPoint <- map["user_image"]
        companyName <- map["company_name"]
        licenseImage <- map["license_image"]
        licenseNumber <- map["driving_license_number"]
        socialSecurityNumber <- map["social_security_number"]
        rating <- map["rating"]
        plateNumber <- map["platenumber"]
        access <- map["access_level"]
        userImage = "https://staging.hydd.caansoft.com/media/\(userImageEndPoint)"
    }
}
