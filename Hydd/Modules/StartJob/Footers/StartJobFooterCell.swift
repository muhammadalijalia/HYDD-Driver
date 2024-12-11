//
//  StartJobFooterCell.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 10/02/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit
protocol StartJobFooterCellProtocol: class {
    func cancelPressed()
    func startPressed()
    func trackPressed()
}
class StartJobFooterCell: UITableViewHeaderFooterView {
    @IBOutlet weak var buttonStartJob: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonTrackLocation: UIButton!
    @IBOutlet weak var viewAccept: UIView!
    @IBOutlet weak var viewCancel: UIView!
    @IBOutlet weak var viewTrackLocation: UIView!
    
    weak var delegate: StartJobFooterCellProtocol?
    
    @IBAction func actionStartJob(_ sender: UIButton) {
        self.delegate?.startPressed()
    }
    @IBAction func actionCancelJob(_ sender: Any) {
        self.delegate?.cancelPressed()
    }
    @IBAction func actionTrackLocation(_ sender: UIButton) {
        self.delegate?.trackPressed()
    }
}
extension StartJobFooterCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let type = object as? ScreenTypeVehicleDetail else {return}
        switch type {
        case .progress:
            viewCancel.isHidden = false
            self.buttonStartJob.setAttributedTitle(DJM.shared.getValue(view: "start_job_view", variable: "start").styled(as: .helveticaRegular_20sp), for: .normal)
        case .listing:
            viewCancel.isHidden = true
            self.buttonStartJob.setAttributedTitle(DJM.shared.getValue(view: "start_job_view", variable: "accept").styled(as: .helveticaRegular_20sp), for: .normal)
        }
        self.buttonTrackLocation.setAttributedTitle(DJM.shared.getValue(view: "start_job_view", variable: "track").styled(as: .helveticaRegular_20sp), for: .normal)
        self.buttonCancel.setAttributedTitle(DJM.shared.getValue(view: "start_job_view", variable: "cancel").styled(as: .helveticaRegular_20sp), for: .normal)
    }
}
