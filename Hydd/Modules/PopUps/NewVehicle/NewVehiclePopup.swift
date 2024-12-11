//
//  NewVehiclePopup.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 04/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class NewVehiclePopup: UIView {
    
    @IBOutlet weak var viewYes: UIView!
    @IBOutlet weak var viewNo: UIView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var viewCorner: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewCorner.cornerRadius(cornerRadius: 10)
        buttonYes.cornerRadius(cornerRadius: 6)
        buttonNo.cornerRadius(cornerRadius: 6)
    }
    
    func setClass(classVehicle: String) {
        giveBtnCornerRadiusWithTheDarkBackGround(view: viewYes, btn: buttonYes)
        giveBtnCornerRadiusWithTheDarkBackGround(view: viewNo, btn: buttonNo, type: .cancel)
        let attDescription = (DJM.shared.getValue(view: "popups_view", variable: "new_vehicle_1") + "\(classVehicle)" + DJM.shared.getValue(view: "popups_view", variable: "new_vehicle_2") + "\(classVehicle)" + DJM.shared.getValue(view: "popups_view", variable: "new_vehicle_3") + "\(classVehicle)" + DJM.shared.getValue(view: "popups_view", variable: "new_vehicle_4") + "\(classVehicle)" + DJM.shared.getValue(view: "popups_view", variable: "new_vehicle_5")).styled(as: .helveticaRegular_20sp_gray)
        
        labelDescription.attributedText = attDescription
        
        buttonNo.setAttributedTitle(DJM.shared.getValue(view: "popups_view", variable: "no").styled(as: .helveticaRegular_20sp), for: .normal)
        buttonNo.backgroundColor = .hyddRed
        buttonYes.setAttributedTitle(DJM.shared.getValue(view: "popups_view", variable: "yes").styled(as: .helveticaRegular_20sp), for: .normal)
        buttonYes.backgroundColor = .hyddblue
    }
}
