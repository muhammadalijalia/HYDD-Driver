//
//  UpgradeManager.swift
//  Sippy
//
//  Created by Syed Kashan on 11/21/19.
//  Copyright (c) 2019 Syed Kashan. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject

protocol IUpgradeManager: class {
    func showForcedUpgradePopUp(response: [String: Any])
    func showOptionalUpgradePopUp(response: [String: Any])
}

class UpgradeManager: IUpgradeManager {
    static let shared = UpgradeManager()

       private init() { }

       deinit {
           print("deinit singleton")
       }

       func showForcedUpgradePopUp(response: [String: Any]) {
//           DispatchQueue.main.async {
////               let controller = FeatureRouter.createModule(type: .forceUpgrade)
//            let controller = SippyErrorDialogRouter.createModule(screenType: .error, title: "UPGRADE", description: "something about upgrade", okTitle: "OK")
//               controller.modalPresentationStyle = .overFullScreen
//               controller.modalTransitionStyle = .crossDissolve
//               UIViewController.top().present(controller, animated: true) {
//                   //Presented
//               }
//           }
       }

       func showOptionalUpgradePopUp(response: [String: Any]) {
//           DispatchQueue.main.async {
//               let controller = SippyErrorDialogRouter.createModule(screenType: .error, title: "UPGRADE", description: "something about upgrade", okTitle: "OK")
//               controller.modalPresentationStyle = .overFullScreen
//               controller.modalTransitionStyle = .crossDissolve
//               
//               UIViewController.top().present(controller, animated: true) {
//                   //Presented
//               }
//           }
       }

}
