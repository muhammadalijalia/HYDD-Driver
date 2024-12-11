//
//  UILabelExtension.swift
//  Sippy
//
//  Created by Kashan on 08/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UILabel {
    func setLabelFeatures(text: String ,
                          font: String ,
                          size: CGFloat = 15) {
        self.text = text
        self.font = UIFont(name: font, size: size)
    }
}
