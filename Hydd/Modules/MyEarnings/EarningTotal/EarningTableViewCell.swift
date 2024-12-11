//
//  EarningTableViewCell.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 14/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class EarningTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
extension EarningTableViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let earning = object as? Double else {return}
        self.labelTime.attributedText = "\(earning)€".styled(as: .gibsonRegular_50sp)
    }
}
