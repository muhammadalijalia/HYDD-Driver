//
//  EmailVerifyViewController.swift
//  HYDD-driver
//
//  Created Syed Kashan on 01/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class EmailVerifyViewController: BaseViewController, EmailVerifyViewProtocol {
    
    @IBOutlet weak var viewOk: UIView!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var labelSecurity: UILabel!
    @IBOutlet weak var buttonOK: UIButton!
	var presenter: EmailVerifyPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func actionOK(_ sender: UIButton) {
        self.presenter?.update()
    }
    @IBAction func actionCross(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension EmailVerifyViewController: SetupViewController {
    func setupNavigation() {
    }
    
    func setupView() {
        textfieldPassword.setLeftPaddingPoints(15)
        giveBtnCornerRadiusWithTheDarkBackGround(view: viewOk, btn: buttonOK)
        textfieldPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        labelHeading.attributedText = DJM.shared.getValue(view: "change_password_view", variable: "address").styled(as: .gibsonRegular_16sp)
        buttonOK.setAttributedTitle(DJM.shared.getValue(view: "change_password_view", variable: "update").styled(as: .helveticaRegular_20sp), for: .normal)
        buttonOK.roundCorners(6)
        buttonOK.backgroundColor = .hyddblue
        textfieldPassword.becomeFirstResponder()
    }
    
    func networkRequest() {
    }
    
}
extension EmailVerifyViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {return}
        self.presenter?.set(email: text)
    }
}
