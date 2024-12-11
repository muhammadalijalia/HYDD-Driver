//
//  SenderTableViewCell.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 22/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class SenderTableViewCell: UITableViewCell {
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
