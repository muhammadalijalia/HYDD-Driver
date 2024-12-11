//
//  File.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 21/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class MyCarModel: Object, Mappable {
    var data = List<MyCarDetailModel>()
    
    required convenience public init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        data <- map["data"]
    }
}

class MyCarDetailModel: Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var numberPlate: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var brand: String = ""
    var type: String = ""
        
    required convenience public init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        numberPlate <- map["plate_number"]
        color <- map["color"]
        status <- map["status__status"]
        model <- map["model_name"]
        brand <- map["model__brand__name"]
    }
}

infix operator <-
/// Object of Realm's List type
public func <- <T: Mappable>(left: List<T>, right: ObjectMapper.Map) {
    var array: [T]?
    
    if right.mappingType == .toJSON {
        array = Array(left)
    }
    
    array <- right
    
    if right.mappingType == .fromJSON {
        if let theArray = array {
            left.append(objectsIn: theArray)
        }
    }
}
