//
//  UIButtonExtension.swift
//  Sippy
//
//  Created by Kashan on 08/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UIButton {
    func setButtonFeatures(title: String,
                           font: String,
                           size: CGFloat,
                           backgroundColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: font, size: size)
        self.backgroundColor = backgroundColor
    }
    
    func setBorderColorAndWidth(color: UIColor,
                                width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    func moveImageLeftTextCenter(image: UIImage, imagePadding: CGFloat, renderingMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderingMode), for: .normal)
        guard let imageViewWidth = self.imageView?.frame.width else {return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else {return}
        self.contentHorizontalAlignment = .left
        let imageLeft = imagePadding - imageViewWidth / 2
        let titleLeft = (bounds.width - titleLabelWidth) / 2 - imageViewWidth
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageLeft, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleLeft, bottom: 0.0, right: 0.0)
    }
    
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
}
