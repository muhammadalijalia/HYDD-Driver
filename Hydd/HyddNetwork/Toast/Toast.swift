//
//  Toast.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation
import UIKit

class Toast {
    static func showResponseTime(responseTime: TimeInterval, request: URL?) {
        let requestURL = request?.absoluteString
        let requestURLFormatted = requestURL?.replacingOccurrences(of: "https://api-stage.sippy.com",
                                                                   with: "{base_url}",
                                                                   options: .literal,
                                                                   range: nil)
        let _ = "URL \(requestURLFormatted ?? "Unknown")\nResponse Time \(responseTime)"
//        DispatchQueue.main.async {
//            UIViewController.topView().view.makeToast(message, duration: 3.0, position: .top)
//        }
    }
}
