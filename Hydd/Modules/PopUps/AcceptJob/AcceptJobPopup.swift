//
//  AcceptJobPopup.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 03/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class AcceptJobPopup: UIView {
    
    @IBOutlet weak var viewYes: UIView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textFieldCar: UITextField!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var viewCorner: UIView!
    
    var car: MyCarDetailModel?
    var myVehicles: [MyCarDetailModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldCar.setLeftPaddingPoints(15)
        textFieldCar.delegate = self
        let attDescription = DJM.shared.getValue(view: "popups_view", variable: "accept_1").styled(as: .helveticaRegular_20sp_gray)
        attDescription.append(DJM.shared.getValue(view: "popups_view", variable: "accept_2").styled(as: .helveticaRegular_20sp_gray))
        attDescription.append(DJM.shared.getValue(view: "popups_view", variable: "accept_3").styled(as: .helveticaRegular_20sp_gray))
        labelDescription.attributedText = attDescription
        
        buttonConfirm.setAttributedTitle(DJM.shared.getValue(view: "popups_view", variable: "confirm").styled(as: .helveticaRegular_20sp), for: .normal)
        buttonConfirm.backgroundColor = .hyddblue
        buttonConfirm.roundCorners(6)
        
        let pickerViewCar = UIPickerView()
        pickerViewCar.delegate = self
        pickerViewCar.dataSource = self
        textFieldCar.inputView = pickerViewCar
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewCorner.cornerRadius(cornerRadius: 10)
    }
    
    func setClass(vehicleClass: String) {
        self.myVehicles = HCM.shared.getCarsOfMyClass(vehicleClass: vehicleClass)
    }
}
extension AcceptJobPopup: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldCar.attributedText = myVehicles?[row].numberPlate.styled(as: .gibsonRegular_15sp) ?? "".styled(as: .gibsonRegular_15sp)
        car = myVehicles?[row]
    }
}
extension AcceptJobPopup: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = myVehicles else {return 0}
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        guard let data = myVehicles?[row].numberPlate else {return "".styled(as: .gibsonRegular_15sp)}
        return "\(data)".styled(as: .gibsonRegular_15sp)
    }
}

extension AcceptJobPopup: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 < 1 {
            textFieldCar.attributedText = myVehicles?[0].numberPlate.styled(as: .gibsonRegular_15sp) ?? "".styled(as: .gibsonRegular_15sp)
            car = myVehicles?[0]
        }
    }
}
