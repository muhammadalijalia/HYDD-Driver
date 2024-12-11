//
//  FloatingTextField.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 11/04/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation

class FloatingTextField: SkyFloatingLabelTextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = UIColor.hyddblue
        textColor = UIColor(hexString: "#454F63")
        backgroundColor = UIColor.white
        roundCorners(12)
        setLeftPaddingPoints(15)
        font = UIFont(name: "Gibson-Regular", size: 15)
        titleLabel.isHidden = true
        titleLabel.font =  UIFont(name: "Gibson-Regular", size: 14)
        placeholderFont = UIFont(name: "Gibson-Regular", size: 14)
        placeholderColor = UIColor(hexString: "#78849E")
        titleColor = UIColor.hyddblue
        selectedTitleColor = UIColor.hyddblue
        lineHeight = 0.0
        selectedLineHeight = 0.0
        lineColor = UIColor.lightGray
        selectedLineColor = UIColor.hyddblue
        errorColor = .hyddRed
    }
}
