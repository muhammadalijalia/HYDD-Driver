//
//  CancelJobPopUp.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 04/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class CancelJobPopUp: UIView {

    @IBOutlet weak var viewNo: UIView!
    @IBOutlet weak var viewYes: UIView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var viewCorner: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        giveBtnCornerRadiusWithTheDarkBackGround(view: viewYes, btn: buttonYes)
        giveBtnCornerRadiusWithTheDarkBackGround(view: viewNo, btn: buttonNo, type: .cancel )
        let attDescription = DJM.shared.getValue(view: "popups_view", variable: "cancel_1").styled(as: .helveticaRegular_20sp_gray)
        attDescription.append(DJM.shared.getValue(view: "popups_view", variable: "cancel_2").styled(as: .helveticaBold_20sp_gray))
        attDescription.append(DJM.shared.getValue(view: "popups_view", variable: "cancel_3").styled(as: .helveticaRegular_20sp_gray))
        labelDescription.attributedText = attDescription
        
        buttonNo.setAttributedTitle(DJM.shared.getValue(view: "popups_view", variable: "no").styled(as: .helveticaRegular_20sp), for: .normal)
        buttonNo.backgroundColor = .hyddRed
        buttonNo.roundCorners(6)
        
        buttonYes.setAttributedTitle(DJM.shared.getValue(view: "popups_view", variable: "yes").styled(as: .helveticaRegular_20sp), for: .normal)
        buttonYes.backgroundColor = .hyddblue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewCorner.cornerRadius(cornerRadius: 10)
        buttonYes.roundCorners(6)
    }
}
