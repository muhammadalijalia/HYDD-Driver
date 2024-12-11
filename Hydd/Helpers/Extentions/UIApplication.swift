//
//  UIApplication.swift
//  Sippy
//
//  Created by Kashan on 17/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 384
            if let statusBar = keyWindow?.viewWithTag(tag) {
                keyWindow?.bringSubviewToFront(statusBar)
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        } else {
            return nil
        }
    }
}
