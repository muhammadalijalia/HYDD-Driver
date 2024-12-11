//
//  RoundShadowView.swift
//  Hydd driver
//
//  Created by Syed Kashan on 12/04/2019.
//  Copyright © Syed Kashan. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {
    private var redLayer: CAShapeLayer!
    private var cornerRad: CGFloat = 12
    private var fillColor: UIColor = .white
    
    override func layoutSubviews() {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRad).cgPath
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 12
        layer.cornerRadius = 12
    }
}

extension UIView {
    var isCancelledView: UIView {
        layer.borderColor = UIColor.hyddRed.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 12
        return self
    }
    
    var isAcceptedView: UIView {
        layer.borderColor = UIColor.hyddblue.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 12
        return self
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
