//
//  UIImageView.swift
//  Sippy
//
//  Created by Kashan on 08/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeRoundedImage() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    func makeitdisable(disabled: Bool) {
        if disabled {
            self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = UIColor.lightGray
            self.alpha = 0.5
        }
    }
    func makeitColor(color: UIColor) {
               self.image = self.image?.withRenderingMode(.alwaysTemplate)
               self.tintColor = color
       }
}
