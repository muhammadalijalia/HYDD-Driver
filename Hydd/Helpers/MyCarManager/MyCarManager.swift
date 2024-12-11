//
//  MyCarManager.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 03/06/2020.
//  Copyright (c) 2020 Syed Kashan. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject

protocol IMyCarManager: class 	{
    // do someting...
}

typealias HCM = MyCarManager

class MyCarManager: IMyCarManager {
    
    
    init() {
        if UserDefaults.standard.isUserLogedIn ?? false {
            myCars?.data.removeAll()
            if let myCars = try? RDBM.shared.getAll(with: MyCarModel.self).last {
                self.myCars = myCars
            }
        }
    }
    static let apiClient = APIClient()
    var getCarTask: URLSessionDataTask!
    
    static let shared = MyCarManager()
    var myCars: MyCarModel?
    
    func getCars(id: Int, completionHandler: @escaping (Bool) -> Void) {
        self.getCarTask?.cancel()
        let cars = URLRequest(url: NETWORKCONSTANTS.getMyCars(id: id),
                              method: URLRequest.HTTPMethod.get,
                              body: nil)
        self.getCarTask = MyCarManager.apiClient.dataTask(cars) {[weak self] response in
            //Response
            response.successResponse.flatMap { (data, response) in
                printHydd("Response is \(data) \nResponse \(response)")
                printHydd(String(decoding: data, as: UTF8.self))
                if let dataDictionary = data.getJSONFromData() {
                    if let _ = dataDictionary["message"] as? String {
                        completionHandler(false)
                    } else {
                        if let _ = dataDictionary["data"] as? [[String: Any]] {
                            if let cars = MyCarModel(JSON: dataDictionary) {
                                debugPrint(cars)
                                self?.setCar(set: cars)
                                completionHandler(true)
                            } else {
                                completionHandler(false)
                            }
                        }
                    }
                } else {
                    completionHandler(false)
                }
            }
        }
    }
    
    func setCar(set: MyCarModel) {
        DispatchQueue.main.async {
            RDBM.shared.Save(item: set)
            self.myCars = set
        }
    }
    
    func getCarsOfMyClass(vehicleClass: String) -> [MyCarDetailModel]? {
        let data: [MyCarDetailModel]? = self.myCars?.data.compactMap({$0}) ?? nil
        if data == nil {
            return nil
        }
        let cars = data?.filter({$0.model == vehicleClass})
        if cars != nil {
            return cars
        } else {
            return nil
        }
    }
    
    func getCarClass() -> [MyCarDetailModel]? {
        let data: [MyCarDetailModel]? = self.myCars?.data.compactMap({$0}) ?? nil
        if let dup = data {
            let dataUnique = dup.removingDuplicates(byKey: \.model)
            return dataUnique
        } else {
            return nil
        }
    }
}
