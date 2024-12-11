//
//  APIClient.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

public typealias URLResponse = Result<(data: Data, response: HTTPURLResponse)>

open class APIClient {
    public init() { }
    open func dataTask(_ request: URLRequest,
                       completionHandler: @escaping (URLResponse) -> Void) -> URLSessionDataTask {
        
        // FIX ME: Temporary Time - to be removed in release
        let startDate = Date()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let isMaintenanceUser = UserDefaults.standard.bool(forKey: "MaintenanceUser")
            if isMaintenanceUser {
                // FIX ME: Temporary Time - to be removed in release
                let executionTime = Date().timeIntervalSince(startDate)
                Toast.showResponseTime(responseTime: executionTime, request: request.url)
            }
            
            if let data = data, let response = response as? HTTPURLResponse {
                //print("Response is \(data) \nResponse \(response)")
                
                completionHandler(URLResponse(success: (data, response)))
            } else {
                if error?.localizedDescription != "cancelled" {
                    DispatchQueue.main.async {
                        if UIViewController.top().view.subviews.count > 1 {
                            UIViewController.top().view.subviews.last?.removeFromSuperview()
                        }
                       
                        HMM.shared.showError(title: DJM.shared.getValue(view: "connection", variable: "label_network"), message: DJM.shared.getValue(view: "connection", variable: "network_details"))
                    }
                }
                print("Error is \(error!)")
                completionHandler(URLResponse(failure: error ?? NSError(domain: "virtuosoft.Hydd",
                                                                        code: 9999,
                                                                        userInfo: [:])))
            }
        }
        task.resume()
        return task
    }
}
