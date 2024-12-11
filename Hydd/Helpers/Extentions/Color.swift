//
//  Color.swift
//  Sippy
//
//  Created by Kashan on 08/10/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

class Color {
    static let lightGray = UIColor(hexString: "#CDD0D7")
    static let darkGray = UIColor(hexString: "#767B85")
    static let tfColor = UIColor(hexString: "#A2A7B1")
    static let bgColor = UIColor(hexString: "#9298A4")
    static let navBarColor = UIColor(hexString: "#1f0001")
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
