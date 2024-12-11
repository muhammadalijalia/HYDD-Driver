//
//  ImageUploader.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation
import UIKit

open class ImageUploader {
    
    public static let shared = ImageUploader()
    let apiClient = APIClient()
    var uploadTask: URLSessionDataTask!
    
    private init() {
    }
    
    deinit {
        print("deinit ImageUploader singleton")
    }
    
    open func uploadImage(_ data: Data, urlToUpladImg: String, completionHandler: @escaping (URLResponse) -> Void) {
        
        guard let urlString = URL(string: urlToUpladImg),
            let token = UserDefaults.standard.string(forKey: "authenticationToken") else { return }
        
        let boundaryConstant = "----------------\(UUID().uuidString)"
        
        // create upload data to send
        var uploadData = Data()
        uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: .utf8)!)
        uploadData.append("Content-Disposition: form-data; name=\"img\"; filename=\"file.png\"\r\n".data(using: .utf8)!)
        uploadData.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        uploadData.append(data)
        uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: .utf8)!)
        
        let contentType = "multipart/form-data;boundary=" + boundaryConstant
        let appVersion = getAppVersion()
        let systemVersion = UIDevice.current.systemVersion

        let headers = [ "Content-Type": contentType,
                        "Authorization": token,
                        "x-app-version": appVersion,
                        "x-os-version": systemVersion,
                        "x-device-type": "ios"]
        
        var urlRequest = URLRequest(url: urlString)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = uploadData
        urlRequest.allHTTPHeaderFields = headers
        
        //Cancel if any previous task ongoing
        uploadTask?.cancel()
        
        uploadTask = apiClient.dataTask(urlRequest, completionHandler: { response in
            completionHandler(response)
        })
        uploadTask?.resume()
    }
    
    func getAppVersion() -> String {
        if let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            let version = "\(shortVersion).\(build)"
            return version
        }
        return ""
    }
}
