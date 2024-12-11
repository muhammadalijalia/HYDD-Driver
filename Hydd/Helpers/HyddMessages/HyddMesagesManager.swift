//
//  HyddMesagesManager.swift
//  Hydd
//
//  Created by Syed Kashan on 10/1/19.
//  Copyright (c) 2019 Syed Kashan. All rights reserved.

import Foundation
import Swinject
import SwiftMessages

protocol IHyddMesagesManager: class {
    // do someting...
}

typealias HMM = HyddMesagesManager

class HyddMesagesManager: IHyddMesagesManager {
    // do someting...
    static let shared = HyddMesagesManager()
    
    init() {
    }
    
    func showWarning(title: String, message: String) {
        DispatchQueue.main.async {
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(.warning)
            warning.configureDropShadow()
            let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
            warning.configureContent(title: "\(title)", body: "\(message)", iconText: iconText)
            warning.button?.isHidden = true
            //        warning.backgroundView.backgroundColor = UIColor.
            //        warning.bodyLabel?.textColor = UIColor.white
            var warningConfig = SwiftMessages.defaultConfig
            warningConfig.presentationStyle = .top
            warningConfig.dimMode = .gray(interactive: true)
            warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar.rawValue)
            SwiftMessages.show(config: warningConfig, view: warning)
        }
    }
    func showStatusInfo(message: String) {
        DispatchQueue.main.async {
            let status = MessageView.viewFromNib(layout: .statusLine)
            status.backgroundView.backgroundColor = .hyddblue
            status.bodyLabel?.textColor = UIColor.white
            status.configureContent(body: "\(message)")
            var statusConfig = SwiftMessages.defaultConfig
            statusConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal.rawValue)
            statusConfig.preferredStatusBarStyle = .lightContent
            SwiftMessages.show(config: statusConfig, view: status)
        }
    }
    func showStatusSuccess(message: String) {
        DispatchQueue.main.async {
            let success = MessageView.viewFromNib(layout: .cardView)
            success.configureTheme(.error)
            success.configureTheme(backgroundColor: .hyddblue, foregroundColor: .white)
            success.configureDropShadow()
            success.configureContent(title: "Success", body: "\(message)")
            success.button?.isHidden = true
            var successConfig = SwiftMessages.defaultConfig
            successConfig.duration = .seconds(seconds: 3)
            successConfig.presentationStyle = .center
            successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal.rawValue)
            SwiftMessages.show(config: successConfig, view: success)
        }
    }
    func showBottomInfo(title: String, message: String) {
        DispatchQueue.main.async {
            let info = MessageView.viewFromNib(layout: .cardView)
            info.configureTheme(.info)
            info.configureTheme(backgroundColor: .hyddblue, foregroundColor: .white)
            info.button?.isHidden = true
            info.configureContent(title: "\(title)", body: "\(message)")
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.presentationStyle = .bottom
            
            infoConfig.duration = .seconds(seconds: 3)
            SwiftMessages.show(config: infoConfig, view: info)
        }
    }
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            let error = MessageView.viewFromNib(layout: .cardView)
            error.configureTheme(.error)
            error.configureTheme(backgroundColor: .hyddblue, foregroundColor: .white)
            error.configureContent(title: "\(title)", body: "\(message)")
            error.button?.isHidden = true
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.duration = .seconds(seconds: 3)
            SwiftMessages.show(config: infoConfig, view: error)
        }
    }
    func showSimpleMessage() {
        DispatchQueue.main.async {
            let error = MessageView.viewFromNib(layout: .tabView)
            error.configureTheme(.error)
            error.configureContent(title: "Error", body: "Something is horribly wrong!")
            error.button?.setTitle("Stop", for: .normal)
            
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(.warning)
            warning.configureDropShadow()
            
            let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
            warning.configureContent(title: "Warning", body: "Consider yourself warned.", iconText: iconText)
            warning.button?.isHidden = true
            var warningConfig = SwiftMessages.defaultConfig
            warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar.rawValue)

            let success = MessageView.viewFromNib(layout: .cardView)
            success.configureTheme(.success)
            success.configureDropShadow()
            success.configureContent(title: "Success", body: "Something good happened!")
            success.button?.isHidden = true
            var successConfig = SwiftMessages.defaultConfig
            successConfig.presentationStyle = .center
            successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal.rawValue)

            let info = MessageView.viewFromNib(layout: .messageView)
            info.configureTheme(.info)
            info.button?.isHidden = true
            info.configureContent(title: "Info", body: "This is a very lengthy and informative info message that wraps across multiple lines and grows in height as needed.")
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.presentationStyle = .bottom
            infoConfig.duration = .seconds(seconds: 0.25)

            let status = MessageView.viewFromNib(layout: .statusLine)
            status.backgroundView.backgroundColor = UIColor.purple
            status.bodyLabel?.textColor = UIColor.white
            status.configureContent(body: "A tiny line of text covering the status bar.")
            var statusConfig = SwiftMessages.defaultConfig
            statusConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar.rawValue)

            let status2 = MessageView.viewFromNib(layout: .statusLine)
            status2.backgroundView.backgroundColor = UIColor.orange
            status2.bodyLabel?.textColor = UIColor.white
            status2.configureContent(body: "Switched to light status bar!")
            var status2Config = SwiftMessages.defaultConfig
            status2Config.presentationContext = .window(windowLevel: UIWindow.Level.normal.rawValue)
            status2Config.preferredStatusBarStyle = .lightContent

            SwiftMessages.show(view: error)
            SwiftMessages.show(config: warningConfig, view: warning)
            SwiftMessages.show(config: successConfig, view: success)
            SwiftMessages.show(config: infoConfig, view: info)
            SwiftMessages.show(config: statusConfig, view: status)
            SwiftMessages.show(config: status2Config, view: status2)
        }
    }
}
