//
//  ClientManager.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 08/06/2020.
//  Copyright (c) 2020 Syed Kashan. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject

protocol IClientManager: class 	{
    // do someting...
}

typealias HDCM = ClientManager

class ClientManager: IClientManager {
    
    static let shared = ClientManager()
    static let apiClient = APIClient()
    var clientUserDetails: ClientModel?
    var getClientDetailsTask: URLSessionDataTask!
    var waitingTask: URLSessionDataTask!
    var onBoardTask: URLSessionDataTask!
    var dayCompleteTask: URLSessionDataTask!
    var closeTask: URLSessionDataTask!
    var updateHourTask: URLSessionDataTask!
    var missionTask: URLSessionDataTask!
    
    
    init() {
        if UserDefaults.standard.isUserLogedIn ?? false {
            if let myClient = try? RDBM.shared.getAll(with: ClientModel.self).last {
                self.clientUserDetails = myClient
            }
        }
    }
    
    func getMissionData(missionId: Int, completionHandler: @escaping (Bool, CarSummaryModel) -> Void) {
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.missionTask?.cancel()
                let missionURL = URLRequest(url: NETWORKCONSTANTS.getMissionById(id: missionId),
                                            method: URLRequest.HTTPMethod.get,
                                            body: nil)
                self.missionTask = ClientManager.apiClient.dataTask(missionURL) {response in
                    //Response
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let _ = dataDictionary["message"] as? String {
                                completionHandler(false, CarSummaryModel())
                            } else {
                                if let data = dataDictionary["data"] as? [[String: Any]] {
                                    if let missionParsed = CarSummaryModel(JSON: data[0]) {
                                        completionHandler(true, missionParsed)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func driverWaiting(completionHandler: @escaping (Bool, String) -> Void) {
        guard let id = HUM.shared.user?.id,
            let missionId = HDCM.shared.clientUserDetails?.missionId else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.waitingTask?.cancel()
                let url = URLRequest(url: NETWORKCONSTANTS.waitingClient(id: id, missionId: missionId),
                                     method: URLRequest.HTTPMethod.patch,
                                     body: nil)
                self.waitingTask = ClientManager.apiClient.dataTask(url) { [weak self] response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                completionHandler(false, message)
                            } else {
                                if let clientData = ClientModel(JSON: dataDictionary) {
                                    self?.updateStatus(status: clientData.status)
                                }
                                completionHandler(true, "Success")
                            }
                        } else {
                            completionHandler(false, "Something went wrong! try again.")
                        }
                    }
                }
            }
        }
    }
    func clienOnBoard(completionHandler: @escaping (Bool, String) -> Void) {
        guard let id = HUM.shared.user?.id,
            let missionId = HDCM.shared.clientUserDetails?.missionId else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.onBoardTask?.cancel()
                let url = URLRequest(url: NETWORKCONSTANTS.onBoardClient(id: id, missionId: missionId),
                                     method: URLRequest.HTTPMethod.patch,
                                     body: nil)
                self.onBoardTask = ClientManager.apiClient.dataTask(url) { [weak self] response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                completionHandler(false, message)
                            } else {
                                if let clientData = ClientModel(JSON: dataDictionary) {
                                    self?.updateStatus(status: clientData.status)
                                }
                                completionHandler(true, "Success")
                            }
                        } else {
                            completionHandler(false, "Something went wrong! try again.")
                        }
                    }
                }
            }
        }
    }
    func driverDayCompleted(completionHandler: @escaping (Bool, String) -> Void) {
        guard let id = HUM.shared.user?.id,
            let missionId = HDCM.shared.clientUserDetails?.missionId else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.dayCompleteTask?.cancel()
                let url = URLRequest(url: NETWORKCONSTANTS.completeDay(id: id, missionId: missionId),
                                     method: URLRequest.HTTPMethod.patch,
                                     body: nil)
                self.dayCompleteTask = ClientManager.apiClient.dataTask(url) { [weak self] response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                completionHandler(false, message)
                            } else {
                                if let clientData = ClientModel(JSON: dataDictionary) {
                                    self?.updateStatus(status: clientData.status)
                                }
                                completionHandler(true, "Success")
                            }
                        } else {
                            completionHandler(false, "Something went wrong! try again.")
                        }
                    }
                }
            }
        }
    }
    func driverCloseMission(completionHandler: @escaping (Bool, String) -> Void) {
        guard let id = HUM.shared.user?.id,
            let missionId = HDCM.shared.clientUserDetails?.missionId else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.closeTask?.cancel()
                let url = URLRequest(url: NETWORKCONSTANTS.closeMission(id: id, missionId: missionId),
                                     method: URLRequest.HTTPMethod.patch,
                                     body: nil)
                self.closeTask = ClientManager.apiClient.dataTask(url) { response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                completionHandler(false, message)
                            } else {
                                completionHandler(true, "Success")
                            }
                        } else {
                            completionHandler(false, "Something went wrong! try again.")
                        }
                    }
                }
            }
        }
    }
    func clientNoShow(completionHandler: @escaping (Bool, String) -> Void) {
        guard let id = HUM.shared.user?.id,
            let missionId = HDCM.shared.clientUserDetails?.missionId else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.closeTask?.cancel()
                let url = URLRequest(url: NETWORKCONSTANTS.clientGhost(id: id, missionId: missionId),
                                     method: URLRequest.HTTPMethod.patch,
                                     body: nil)
                self.closeTask = ClientManager.apiClient.dataTask(url) { response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                completionHandler(false, message)
                            } else {
                               // HDCM.shared.removeClient()
                                completionHandler(true, "Success")
                            }
                        } else {
                            completionHandler(false, "Something went wrong! try again.")
                        }
                    }
                }
            }
        }
    }
    func updateConsumedHoursNDistance(para: [String: Any], completionHandler: @escaping (Bool) -> Void) {
        guard let id = HDCM.shared.clientUserDetails?.userId,
            let missionId = HDCM.shared.clientUserDetails?.missionId else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess {
                self.updateHourTask?.cancel()
                let url = URLRequest(url: NETWORKCONSTANTS.updateConsumed(idClient: id, missionId: missionId),
                                     method: URLRequest.HTTPMethod.patch,
                                     body: para)
                self.closeTask = ClientManager.apiClient.dataTask(url) { response in
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                printHydd(message)
                                completionHandler(false)
                            } else {
                                if let km = dataDictionary["rem_km"] as? Int,
                                    let sec = dataDictionary["rem_secs"] as? Int {
                                    NotificationCenter.default.post(name: Notification.Name("remainingValues"),
                                    object: nil,
                                    userInfo: ["km": km,
                                               "sec": sec])
                                    completionHandler(true)
                                } else {
                                    HDCM.shared.removeClient()
                                    completionHandler(true)
                                }
                            }
                        } else {
                            completionHandler(false)
                        }
                    }
                }
            }
        }
    }
    
    func getStatus() -> StatusTypes? {
        guard let status = self.clientUserDetails?.status else {return nil}
        if status == "in_progress" {
            return .inProgress
        } else if status == "confirm" {
            return .confirm
        } else if status == "waiting for client" {
            return .waitingClient
        } else if status == "day completed" {
            return .dayCompleted
        } else if status == "client onboard" {
            return .onBoardClient
        } else if status == "cancel" {
            return .cancel
        } else if status == "close" {
            return .close
        } else if status == "pending" {
            return .pending
        } else {
            return nil
        }
    }
    
    func isUpdatingKMHours() -> Bool {
        guard let details = self.clientUserDetails else {return false}
        print(details)
        if (details.status == "waiting for client" || details.status == "client onboard") && details.orderName == "As Directed" {
            return true
        } else {
            return false
        }
    }
    func setCustomerDetails(set: ClientModel) {
        DispatchQueue.main.async {
            self.clientUserDetails = set
            RDBM.shared.Save(item: set)
        }
    }
    func removeClient() {
        DispatchQueue.main.async {
            RDBM.shared.deleteALLObject(with: ClientModel.self)
            self.clientUserDetails = nil
        }
    }
    func updateStatus(status: String) {
        DispatchQueue.main.async {
            RDBM.shared.updateClientStatus(status: status)
        }
    }
}
