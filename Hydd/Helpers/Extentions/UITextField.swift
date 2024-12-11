//
//  UITextFieldExtension.swift
//  Sippy
//
//  Created by Kashan on 08/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UITextField {
    func setTFFeatures(font: String,
                       size: CGFloat,
                       placeholder: String,
                       textColor: UIColor,
                       tint: UIColor) {
        self.font = UIFont(name: font, size: size)
        self.placeholder = placeholder
        self.textColor = textColor
        self.tintColor = tint
    }
    
    func setTFBorderStyle(borderWidth: CGFloat,
                          borderColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(animation, forKey: "position")
    }
    func setRightImage(img: UIImage) {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imgView.image = img
        imgView.contentMode = .right
        rightView = imgView
        rightViewMode = .always
    }
    func setRightImageButton(img: UIImage, notSelected: UIImage) {
        let button = UIButton(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        button.contentMode = .right
        if button.isSelected {
            button.imageView?.image = img
        } else {
            button.imageView?.image = notSelected
        }
//        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        imgView.image = img
//        imgView.contentMode = .right
        rightView = button
        rightViewMode = .always
    }

}

