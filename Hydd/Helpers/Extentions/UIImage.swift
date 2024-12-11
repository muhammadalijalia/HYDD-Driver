//
//  UIImage.swift
//  Sippy
//
//  Created by Syed Kashan on 12/10/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

extension UIImage {
    func jpeg(_ quality: JPEGQuality) -> UIImage? {
        guard let data = self.jpegData(compressionQuality: quality.rawValue),
            let image = UIImage(data: data)
            else { return nil }
        return image
    }
}

enum JPEGQuality: CGFloat {
    case lowest  = 0
    case low     = 0.25
    case medium  = 0.5
    case high    = 0.75
    case highest = 1
}
