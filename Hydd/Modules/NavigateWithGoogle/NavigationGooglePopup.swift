//
//  NavigationGooglePopup.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 20/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

protocol NavigationGoogleDelegate: class {
    func actionNavigate()
    func actionNavigateWithWaze()
}

class NavigationGooglePopup: UIViewController {

    @IBOutlet weak var viewCorner: UIView!
    @IBOutlet weak var labelGoogleMap: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var lblWazeTitle: UILabel!
    @IBOutlet weak var lblNoGps: UILabel!
    
    weak var delegate: NavigationGoogleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.attributedText = DJM.shared.getValue(view: "navigate_view", variable: "navigate").styled(as: .gibsonRegular_21sp)
        labelGoogleMap.attributedText = "Google map".styled(as: .gibsonRegular_15sp)
        lblWazeTitle.attributedText = "Waze".styled(as: .gibsonRegular_15sp)
        lblNoGps.attributedText = "No GPS".styled(as: .gibsonRegular_15sp)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.viewCorner.layoutIfNeeded()
        viewCorner.roundCorners([.topLeft, .topRight], radius: 10)
    }
    
    @IBAction func actionGoogleMap(_ sender: UIButton) {
        delegate?.actionNavigate()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func actionWazeMap(_ sender: Any) {
        delegate?.actionNavigateWithWaze()
        dismiss(animated: true, completion: nil)
    }
}
