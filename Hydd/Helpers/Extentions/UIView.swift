//
//  UIViewExtension.swift
//  Sippy
//
//  Created by Kashan on 08/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UIView {
    
    var ending: CGPoint { return CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height) }
    var viewWidth: CGFloat { return frame.width }
    var viewHeight: CGFloat { return frame.height }
    
    func roundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = corners
        } else {
            // Fallback on earlier versions
        }
          self.layer.cornerRadius = radius
          self.layer.borderWidth = borderWidth
          self.layer.borderColor = borderColor.cgColor
    }
    
    func rotate(imageView: UIImageView, aCircleTime: Double) { //CABasicAnimation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2 //Minus can be Direction
        rotationAnimation.duration = aCircleTime
        rotationAnimation.repeatCount = .infinity
        imageView.layer.add(rotationAnimation, forKey: nil)
    }
    
    enum typeButton {
        case accept, cancel, missionCancelled
    }
    
    func giveBtnCornerRadiusWithTheDarkBackGround(view : UIView , btn : UIButton, type: typeButton = .accept) {
        view.layer.cornerRadius = 6
        btn.layer.cornerRadius = 6
        view.clipsToBounds = true
        btn.clipsToBounds = true
        switch type {
        case .accept:
            btn.backgroundColor = .hyddblue
            view.backgroundColor = .hyddblue
        case .cancel:
            btn.backgroundColor = .hyddRed
            view.backgroundColor = .hyddRed
        case .missionCancelled:
            btn.backgroundColor = .lightGray
            view.backgroundColor = .lightGray
        }
        
        btn.setTitleColor(textColor, for: .normal)
        
    }
    
    func makeItBlueWithOpacity(_ opacity: CGFloat) {
        self.backgroundColor = .hyddblue
        self.alpha = opacity
    }
    
    func setOpacity(_ opacity: CGFloat) {
        self.alpha = opacity
    }
    
    func makeItGradientWithOpacity(_ opacity: CGFloat) {
        
        self.removeIfAnyGradient()
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        let black = UIColor.black.withAlphaComponent(0.55).cgColor
        gradient.colors = [black, UIColor.clear.cgColor, black]
        printHydd("=========================================")
        printHydd(self.frame)
        printHydd(gradient.frame)
        gradient.name = "HYDDGRADIENT"
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func removeIfAnyGradient() {
        guard let alllayers  = self.layer.sublayers else { return  }
        for la in alllayers where la.name == "HYDDGRADIENT" {
                la.removeFromSuperlayer()
        }
    }
    
    func addFadeAnimation() {
        
        self.transform = .identity
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.repeat, .autoreverse, .curveEaseInOut, .allowUserInteraction], animations: {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
    }
    func addPulsAnimation(duration: Double = 1, fromValue: Double = 0.1, toValue: Double = 1) {
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        pulseAnimation.duration = duration
        pulseAnimation.fromValue = fromValue
        pulseAnimation.toValue = toValue
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(pulseAnimation, forKey: "animateOpacity")
    }

    func makeItGradientWithOrangeHydd(colorRight: UIColor, colorLeft: UIColor) {
        self.removeIfAnyGradient()
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [colorRight.cgColor, colorLeft.cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.locations = [0, 1]
        gradient.frame = bounds
        gradient.name = "HYDDGRADIENT"
        self.layer.insertSublayer(gradient, at: 0)
    }
    class func fromNib<T: UIView>() -> T {
        return (Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T)!
    }
    
}
extension UIImage {
    convenience init(view: UIView) {

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.init(cgImage: (image?.cgImage)!)

  }
}

extension ViewStyle where Self: UIView {
    
    @discardableResult func setRound() -> Self {
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult func cornerRadius(cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult func borderColor(color: UIColor, borderWidth: CGFloat = 1.0) -> Self {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult func shadow(color: UIColor = UIColor.black.withAlphaComponent(0.3),
                                   shadowOffset: CGSize = CGSize(width: 1.0, height: 1.0),
                                   shadowOpacity: Float = 0.7) -> Self {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = false
        return self
    }
    
    @discardableResult func backGroundColor(color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
}
