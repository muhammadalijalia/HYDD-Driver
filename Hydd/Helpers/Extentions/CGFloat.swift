//
//  CGFloat.swift
//  Sippy
//
//  Created by Syed Kashan on 10/14/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit
extension CGFloat {
    var half: CGFloat { return self / 2 }
    var double: CGFloat { return self * 2 }
    
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
