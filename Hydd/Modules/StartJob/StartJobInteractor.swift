//
//  StartJobInteractor.swift
//  HYDD-driver
//
//  Created Syed Kashan on 09/02/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class StartJobInteractor: StartJobInteractorInputProtocol {
    
    weak var presenter: StartJobInteractorOutputProtocol?
    
    static let apiClient = APIClient()
    var registerTask: URLSessionDataTask!
    var startTask: URLSessionDataTask!
    var cancelTask: URLSessionDataTask!
    
    func registerMission(para: [String : Any], plateNumber: String) {
        guard let id = HUM.shared.user?.id else {return}
        HUM.shared.editProfile(para: ["platenumber": plateNumber]) { (isSuccess, message) in
            if isSuccess {
                self.registerTask?.cancel()
                let registerUrl = URLRequest(url: NETWORKCONSTANTS.confirmMission(id: id),
                                             method: URLRequest.HTTPMethod.post,
                                             body: para)
                self.registerTask = StartJobInteractor.apiClient.dataTask(registerUrl) {[weak self] response in
                    //Response
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                HMM.shared.showError(title: "Error", message: message)
                            } else {
                                self?.presenter?.successRegister()
                            }
                        } else {
                            self?.presenter?.failureRegister(text: DJM.shared.getValue(view: "start_job_view", variable: "went_wrong"))
                        }
                    }
                }
            } else {
                self.presenter?.failureUpdatePlateNumber(text: message)
            }
        }
    }
    
    func startMisson(missionId: Int, plateNumber: String) {
        guard let id = HUM.shared.user?.id else {return}
        HUM.shared.editProfile(para: ["platenumber": plateNumber]) { (isSuccess, message) in
            if isSuccess {
                self.startTask?.cancel()
                let registerUrl = URLRequest(url: NETWORKCONSTANTS.startMission(id: id, missionId: missionId),
                                             method: URLRequest.HTTPMethod.patch,
                                             body: nil)
                self.startTask = StartJobInteractor.apiClient.dataTask(registerUrl) {[weak self] response in
                    //Response
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                self?.presenter?.failureStart(text: message)
                            } else {
                                if let clientData = ClientModel(JSON: dataDictionary) {
                                    HDCM.shared.setCustomerDetails(set: clientData)
                                }
                                DispatchQueue.main.async {
                                    guard let id = HUM.shared.user?.id,
                                        let client = HDCM.shared.clientUserDetails else {return}
                                    APPCONSTANT.Chats.databaseChats.child("Chat_\(id)/\(client.userId)").observe(.childAdded) { (snapshot) in
                                        if var data = snapshot.value as? [String: Any] {
                                            let childKey = snapshot.key
                                            data["is_active"] = 1
                                            APPCONSTANT.Chats.databaseChats.child("Chat_\(id)/\(client.userId)").child(childKey).setValue(data)
                                            APPCONSTANT.Chats.databaseChats.child("Chat_\(client.userId)/\(id)").child(childKey).setValue(data)
                                        }
                                    }
                                    //Send current location now
                                    if let location = HLM.shared.myCurrentLocation {
                                        let para = ["is_driver": 1,
                                                    "driver_id": id,
                                                    "lat": location.coordinate.latitude,
                                                    "lng": location.coordinate.longitude] as [String: Any]
                                        APPCONSTANT.Chats.databaseRoot.child("location_\(client.userId)_\(id)_currentLocation").setValue(para)
                                    }
                                }
                                self?.presenter?.successStart()
                            }
                        } else {
                            self?.presenter?.failureStart(text: DJM.shared.getValue(view: "start_job_view", variable: "went_wrong"))
                        }
                    }
                }
            } else {
                self.presenter?.failureUpdatePlateNumber(text: message)
            }
        }
    }
    func cancelJob(missionId: Int) {
        guard let id = HUM.shared.user?.id else {return}
        HUM.shared.getToken { isSuccess in
            if isSuccess{
                self.cancelTask?.cancel()
                let cancelUrl = URLRequest(url: NETWORKCONSTANTS.cancelMission(id: id, missionId: missionId),
                                           method: URLRequest.HTTPMethod.patch,
                                           body: nil)
                self.cancelTask = StartJobInteractor.apiClient.dataTask(cancelUrl) {[weak self] response in
                    //Response
                    response.successResponse.flatMap { (data, response) in
                        printHydd("Response is \(data) \nResponse \(response)")
                        printHydd(String(decoding: data, as: UTF8.self))
                        if let dataDictionary = data.getJSONFromData() {
                            if let message = dataDictionary["message"] as? String {
                                self?.presenter?.failureCancelJob(text: message)
                            } else {
                                self?.presenter?.successCancelJob()
                                DispatchQueue.main.async {
                                    guard let id = HUM.shared.user?.id,
                                          let client = HDCM.shared.clientUserDetails else {return}
                                    APPCONSTANT.Chats.databaseChats.child("Chat_\(id)/\(client.userId)").observe(.childAdded) { (snapshot) in
                                        if var data = snapshot.value as? [String: Any] {
                                            data["is_active"] = 0
                                            let childKey = snapshot.key
                                            APPCONSTANT.Chats.databaseChats.child("Chat_\(id)/\(client.userId)").child(childKey).setValue(data)
                                            APPCONSTANT.Chats.databaseChats.child("Chat_\(client.userId)/\(id)").child(childKey).setValue(data)
                                        }
                                    }
                                }
                            }
                        } else {
                            self?.presenter?.failureCancelJob(text: DJM.shared.getValue(view: "start_job_view", variable: "went_wrong"))
                        }
                    }
                }
            }
        }
    }
}
