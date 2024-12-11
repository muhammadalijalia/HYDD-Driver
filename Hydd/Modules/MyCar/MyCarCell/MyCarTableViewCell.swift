//
//  MyCarTableViewCell.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 18/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class MyCarTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCar: UILabel!
    @IBOutlet weak var imageChevron: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
