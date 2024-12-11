//
//  NewPasswordViewController.swift
//  HYDD-driver
//
//  Created Syed Kashan on 01/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class NewPasswordViewController: BaseViewController, NewPasswordViewProtocol {

    @IBOutlet weak var viewO: UIView!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var labelSecurity: UILabel!
    @IBOutlet weak var buttonOK: UIButton!
	var presenter: NewPasswordPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
    }

    @IBAction func actionOK(_ sender: UIButton) {
        self.presenter?.actionOK()
    }
    @IBAction func actionCross(_ sender: Any) {
        self.presenter?.goBack()
    }
}
extension NewPasswordViewController: SetupViewController {
    func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupView() {
        giveBtnCornerRadiusWithTheDarkBackGround(view: viewO, btn: buttonOK)
        textfieldPassword.setLeftPaddingPoints(15)
        textfieldPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        labelHeading.attributedText = DJM.shared.getValue(view: "change_password_view", variable: "define_new_pass").styled(as: .gibsonRegular_16sp)
        labelSecurity.attributedText = DJM.shared.getValue(view: "change_password_view", variable: "passdesc").styled(as: .gibsonRegular_16sp)
        buttonOK.setAttributedTitle(DJM.shared.getValue(view: "change_password_view", variable: "change_pass").styled(as: .helveticaRegular_20sp), for: .normal)
        buttonOK.roundCorners(6)
        buttonOK.backgroundColor = .hyddblue
        textfieldPassword.becomeFirstResponder()
    }
    
    func networkRequest() {
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            self.showLoadingIndicator()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.hideLoadingIndicator()
        }
    }
    
    func dismissView() {
         DispatchQueue.main.async {
             self.dismiss(animated: true, completion: nil)
         }
    }
}
extension NewPasswordViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {return}
        self.presenter?.set(password: text)
    }
}
