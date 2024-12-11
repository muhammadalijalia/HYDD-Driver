//
//  ForgotPasswordViewController.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 25/01/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController, ForgotPasswordViewProtocol {

    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var viewEmail: RoundShadowView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textfieldEmail: FloatingTextField!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var viewSeperator: UIView!
    var presenter: ForgotPasswordPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigation()
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        self.presenter?.reset()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.presenter?.goBack()
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
    
}
extension ForgotPasswordViewController: SetupViewController {
    func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavigationWithLogoAndBackButton().addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
    }
    
    func setupView() {
        self.labelTitle.attributedText = DJM.shared.getValue(view:  "forgot_password_view", variable:  "forgotlabel").styled(as: .gibsonRegular_13sp)
        self.viewSeperator.backgroundColor = .hyddblue
        self.buttonContinue.setAttributedTitle(DJM.shared.getValue(view:  "forgot_password_view", variable:  "continue").styled(as: .helveticaRegular_20sp), for: .normal)
        self.labelDescription.attributedText = DJM.shared.getValue(view:  "forgot_password_view", variable:  "enter_email").styled(as: .gibsonRegular_18sp_gray)
        giveBtnCornerRadiusWithTheDarkBackGround(view: viewButton, btn: buttonContinue)
        self.textfieldEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func networkRequest() {
    }
    
    func setUserNameTF() {
        self.setUpTF(tf: textfieldEmail, placeholder: "Email")
        textfieldEmail.keyboardType = .emailAddress
    }

    func setUpTF(tf: UITextField, placeholder: String) {
        tf.attributedPlaceholder = placeholder.styled(as: .gibsonRegular_15sp_placeholder)
        tf.delegate = self
    }
    
    func setEmailStatus(error: TfError, status: TFStatus) {
       self.textfieldEmail.errorMessage = error.localizedDescription
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {return}
        self.presenter?.set(email: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
