//
//  HyddTabbarVC.swift
//  Hydd
//
//  Created by Shahzaib Iqbal Bhatti on 3/24/20.
//  Copyright © 2020 Shahzaib Iqbal Bhatti. All rights reserved.
//

import Foundation

import UIKit

class HyddTabbarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.hyddblue
        self.delegate = self
    }
}

extension HyddTabbarVC: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }
}
