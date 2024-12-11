//
//  SideMenuModel.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 26/01/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import UIKit

struct SideMenuModel {
    var id: SideMenu?
    var image: UIImage?
    var name: String?
    
    init(id: SideMenu, image: UIImage, name: String) {
        self.id = id
        self.image = image
        self.name = name
    }
}
