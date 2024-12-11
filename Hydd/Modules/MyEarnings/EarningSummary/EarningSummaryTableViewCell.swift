//
//  EarningSummaryTableViewCell.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 14/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class EarningSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelMission: UILabel!
    @IBOutlet weak var labelTransfers: UILabel!
    @IBOutlet weak var labelDirected: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension EarningSummaryTableViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let data = object as? EarningSummary else {return}
        let mission = "\(data.mission)\n".styled(as: .gibsonRegular_28sp)
        mission.append(DJM.shared.getValue(view: "earnings_view", variable: "mission").styled(as: .gibsonRegular_14sp))
        self.labelMission.attributedText = mission
        
        let transfer = "\(data.transfer)\n".styled(as: .gibsonRegular_28sp)
        transfer.append(DJM.shared.getValue(view: "earnings_view", variable: "transfer").styled(as: .gibsonRegular_14sp))
        self.labelTransfers.attributedText = transfer
        
        let directed = "\(data.dedicated)\n".styled(as: .gibsonRegular_28sp)
        directed.append(DJM.shared.getValue(view: "earnings_view", variable: "directed").styled(as: .gibsonRegular_14sp))
        self.labelDirected.attributedText = directed
    }
}
