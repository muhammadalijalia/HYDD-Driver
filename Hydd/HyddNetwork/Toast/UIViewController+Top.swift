//
//  UIViewController+Top.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public static func topView() -> UIViewController {
        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else { fatalError("No view controller present in app?") }
        var result = rootViewController
        while let vc = result.presentedViewController {
            result = vc
        }
        return result
    }
}
