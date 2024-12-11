//
//  Navigtion+Extention.swift
//  Sippy
//
//  Created by Syed Kashan on 10/21/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func addGradient(_ toAlpha: CGFloat, _ color: UIColor) {
        
        self.removeIfNavAnyGradient()
        let gradient = CAGradientLayer()
        gradient.colors = [
            color.withAlphaComponent(toAlpha).cgColor,
            color.withAlphaComponent(toAlpha).cgColor,
            color.withAlphaComponent(0).cgColor
        ]
        gradient.locations = [0, 0.8, 1]
        var frame = bounds
        frame.size.height += UIApplication.shared.statusBarFrame.size.height
        frame.origin.y -= UIApplication.shared.statusBarFrame.size.height
        gradient.frame = frame
        gradient.name = "SIPPYGRADIENTLAYER"
        layer.insertSublayer(gradient, at: 1)
    }
    func removeIfNavAnyGradient() {
        guard let alllayers  = self.layer.sublayers else { return  }
        for la in alllayers where la.name == "SIPPYGRADIENTLAYER" {
                la.removeFromSuperlayer()
        }
    }
}
