//
//  SideMenuManager.swift
//  Sippy
//
//  Created by Kashan on 09/10/2019.
//  Copyright (c) 2019 Syed Kashan. All rights reserved.

import Foundation
import Swinject

typealias SSMM = SideMenuManager

protocol ISideMenuManager: class {
}

class SideMenuManager: NSObject, ISideMenuManager {
	static let shared = SideMenuManager()
    var isExpanded = false
    var slider = SlideInPresentationManager()
}
extension SideMenuManager {
    
    private func configureSideMenu(screenType: SideMenu) {
        let sideMenu = SideMenuRouter.createModule(screenType: screenType)
        let currentView = UIViewController.top()
        slider.disableCompactHeight = true
        slider.direction = .left
        slider.xAxis = 0
        slider.width = 0.8
        sideMenu.modalPresentationStyle = .custom
        sideMenu.transitioningDelegate = slider
        currentView.present(sideMenu, animated: true)
    }
    
    func showSideMenu(screenType: SideMenu) {
        configureSideMenu(screenType: screenType)
    }
    
    func dismissSideMenu() {
        let currentView = UIViewController.top()
        currentView.dismiss(animated: true)
    }
}
