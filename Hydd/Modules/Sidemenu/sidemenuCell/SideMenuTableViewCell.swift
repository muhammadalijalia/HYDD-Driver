//
//  SideMenuTableViewCell.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 26/01/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var labelMenu: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension SideMenuTableViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let data = object as? SideMenuModel else {return}
        imageLogo.image = data.image
        labelMenu.attributedText = data.name?.styled(as: .gibsonRegular_18sp)
    }
}

