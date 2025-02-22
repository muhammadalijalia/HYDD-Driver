//
//  MyProfileViewController.swift
//  HYDD-driver
//
//  Created Macbook Pro on 15/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class MyProfileViewController: BaseViewController, MyProfileViewProtocol {

    @IBOutlet weak var viewSave: UIView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelPlateNumberValue: UILabel!
    @IBOutlet weak var labelPlateNumber: UILabel!
    @IBOutlet weak var imageFirstStar: UIImageView!
    @IBOutlet weak var imageSecondStar: UIImageView!
    @IBOutlet weak var imageThirdStar: UIImageView!
    @IBOutlet weak var imageFourthStar: UIImageView!
    @IBOutlet weak var imageFifthStar: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var textFieldNumber: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldCar: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var ratingStar1: UIImageView!
    @IBOutlet weak var ratingStar2: UIImageView!
    @IBOutlet weak var ratingStar3: UIImageView!
    @IBOutlet weak var ratingStar4: UIImageView!
    @IBOutlet weak var ratingStar5: UIImageView!
    
    var presenter: MyProfilePresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSelectedCar(_:)), name: APPCONSTANT.NOTIFICATIONS.updateCar, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    @IBAction func actionCross(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionChangeImage(_ sender: Any) {
        presenter?.showPicker()
    }
    @IBAction func actionEmail(_ sender: Any) {
        self.presenter?.gotoEmailVerify()
    }
    @IBAction func actionPassword(_ sender: Any) {
        self.presenter?.gotoPassword()
    }
    @IBAction func actionCar(_ sender: Any) {
        self.presenter?.gotoCarSelect()
    }
    @IBAction func actionSave(_ sender: Any) {
        self.presenter?.updateProfile()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
extension MyProfileViewController: SetupViewController {
    func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupView() {
        textFieldNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        giveBtnCornerRadiusWithTheDarkBackGround(view: viewSave, btn: buttonSave)
        textFieldNumber.font = UIFont(name: "Gibson-Regular", size: 15)
        textFieldNumber.textColor = UIColor(hexString: "#454F63")
        buttonSave.backgroundColor = .hyddblue
        buttonSave.setAttributedTitle(DJM.shared.getValue(view: "profile_view", variable: "save").styled(as: .helveticaRegular_20sp), for: .normal)
        guard let fName = HUM.shared.user?.fName,
            let lName = HUM.shared.user?.LName,
            let pNumber = HUM.shared.user?.phoneNumber,
            let email = HUM.shared.user?.email,
            let address = HUM.shared.user?.address
        else {return}
        labelName.attributedText = "\(fName) \(lName)".styled(as: .gibsonRegular_24sp)
        labelCountry.attributedText = address.styled(as: .gibsonRegular_16sp)
        labelPlateNumber.attributedText = DJM.shared.getValue(view: "profile_view", variable: "plate").styled(as: .gibsonRegular_14sp)
        labelPlateNumberValue.attributedText = DJM.shared.getValue(view: "profile_view", variable: "car_added").styled(as: .gibsonRegular_14sp)
        textFieldCar.attributedText = DJM.shared.getValue(view: "profile_view", variable: "add").styled(as: .gibsonRegular_15sp)
        if let plate = HUM.shared.user?.plateNumber {
            labelPlateNumberValue.attributedText = "\(plate)".styled(as: .gibsonRegular_16sp)
            textFieldCar.attributedText = "\(plate)".styled(as: .gibsonRegular_15sp)
        }
        labelRating.attributedText = DJM.shared.getValue(view: "profile_view", variable: "rating").styled(as: .gibsonRegular_14sp)
        textFieldNumber.attributedText = pNumber.styled(as: .gibsonRegular_15sp)
        textFieldEmail.attributedText = email.styled(as: .gibsonRegular_15sp)
        textFieldPassword.attributedText = "******".styled(as: .gibsonRegular_15sp)
        self.imageUser.makeRoundedImage()
        DispatchQueue.main.async {
            guard let image = HUM.shared.user?.userImage, image.count > 5 else { return }
            ImageManager.shared.setImage(url: image, imageView: self.imageUser)
        }
        guard let rating = HUM.shared.user?.rating else {return}
        let ratingStars: [UIImageView] = [ratingStar1, ratingStar2, ratingStar3, ratingStar4, ratingStar5]
        if rating > 0 {
            for i in 0 ... Int(rating) - 1 {
                ratingStars[i].image = UIImage(named: "icon_filled_star")
            }
        }
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
    
    func setNewImage(image: UIImage) {
        let imageCompressed = image.jpeg(.medium)
        let imageData = imageCompressed?.jpegData(compressionQuality: 0.2)
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        self.presenter?.set(image: base64String ?? "")
        self.imageUser.image = image
    }
    
    @objc func reloadSelectedCar(_ notification: Notification) {
        guard let dict = notification.userInfo as NSDictionary?,
            let name = dict["name"] as? String
            else { return }
        textFieldCar.attributedText = name.styled(as: .gibsonRegular_15sp)
        self.presenter?.set(carPlate: name)
    }
}
extension MyProfileViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == textFieldNumber {
            guard let text = textField.text else {return}
            self.presenter?.set(phone: text)
        }
    }
}
