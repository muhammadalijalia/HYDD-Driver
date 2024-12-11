//
//  NetworkConstants.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

struct NETWORKCONSTANTS {
    //Developer Server
    static let baseURL = "https://staging.hydd.caansoft.com/api/v1/driver/"
    static let newBaseURL = "https://staging.hydd.caansoft.com/api/v1/"
    
//    // waris machine
//    static let baseURL = "http://172.16.17.17:8030/api/v1/driver/"
//    static let newBaseURL = "http://172.16.17.17:8030/api/v1/"
    
    //Machine Server
//    static let baseURL = "http://172.16.17.124:8010/api/v1/driver/"
//    static let newBaseURL = "http://172.16.17.124:8010/api/v1/"
    
    //Client Server
//    static let baseURL = ""
//    static let newBaseURL = ""
    struct REGISTRATION {
        static let login = baseURL + "login"
        static let forgot = baseURL + "forgot-password"
    }
    struct META {
        static let get = NETWORKCONSTANTS.baseURL + "metadata"
        static let getToken = NETWORKCONSTANTS.newBaseURL+"token"
        static let getVehicleModel = NETWORKCONSTANTS.baseURL + "vehicle-models"
    }
    static func getMission(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "new-missions?driver=\(id)"
    }
    static func getMissionById(id: Int) -> String {
        return NETWORKCONSTANTS.newBaseURL+"missions/\(id)"
    }
    static func getProfile(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/profile"
    }
    static func getMyCars(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/vehicles"
    }
    static func updateEmail(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/change-email"
    }
    static func verifyPassword(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/password-verify"
    }
    static func changePassword(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/change-password"
    }
    static func myEarnings(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/earning"
    }
    static func getMyCurrentMissions(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/my-missions"
    }
    static func getMyCompletedMissions(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/my-close-missions"
    }
    static func confirmMission(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/confirm"
    }
    static func startMission(id: Int, missionId: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/mission/\(missionId)/start"
    }
    static func cancelMission(id: Int, missionId: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/mission/\(missionId)/cancel"
    }
    static func registerCar(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/vehicle-register"
    }
    static func editProfile(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/profile"
    }
    static func waitingClient(id: Int, missionId: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/mission/\(missionId)/waiting-for-client"
    }
    static func onBoardClient(id: Int, missionId: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/mission/\(missionId)/client-onboard"
    }
    static func completeDay(id: Int, missionId: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/mission/\(missionId)/day-completed"
    }
    static func closeMission(id: Int, missionId: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/mission/\(missionId)/close"
    }
    static func clientGhost(id: Int, missionId: Int) -> String {
        return NETWORKCONSTANTS.baseURL + "\(id)/mission/\(missionId)/no-show"
    }
    static func updateConsumed(idClient: Int, missionId: Int) -> String {
        return NETWORKCONSTANTS.newBaseURL+"user/\(idClient)/mission/\(missionId)/consumption"
    }
    static func chatPN() -> String {
        return NETWORKCONSTANTS.newBaseURL+"push-notification"
    }
    static func myRatings(id: Int) -> String {
        return NETWORKCONSTANTS.baseURL+"\(id)/ratings"
       }
}
