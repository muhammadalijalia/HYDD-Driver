//
//  OtherViewController.swift
//  HYDD-driver
//
//  Created Syed Kashan on 04/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class OtherViewController: BaseViewController, OtherViewProtocol {
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonAddImage: UIButton!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelSupport: UILabel!
    @IBOutlet weak var labelMyCars: UILabel!
    @IBOutlet weak var labelEditProfile: UILabel!
    @IBOutlet weak var labelRatings: UILabel!
    @IBOutlet weak var labelLogout: UILabel!
    @IBOutlet weak var ratingStar1: UIImageView!
    @IBOutlet weak var ratingStar2: UIImageView!
    @IBOutlet weak var ratingStar3: UIImageView!
    @IBOutlet weak var ratingStar4: UIImageView!
    @IBOutlet weak var ratingStar5: UIImageView!
    
    var presenter: OtherPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setupView()
        guard let id = HUM.shared.user?.id else {
            return
        }
        HUM.shared.getProfile(id: id) { (_) in}
        
    }
    @IBAction func actionEditProfile(_ sender: UIButton) {
        let controller = MyProfileRouter.createModule()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func actionGetCars(_ sender: UIButton) {
        let controller = MyCarRouter.createModule()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func actionSupport(_ sender: UIButton) {
        let alert = UIAlertController(title: DJM.shared.getValue(view: "others_view", variable: "Support"), message: DJM.shared.getValue(view: "others_view", variable: "selectoption"), preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: DJM.shared.getValue(view: "others_view", variable: "phone"), style: .default , handler:{ (UIAlertAction)in
        } ) )
        alert.addAction(UIAlertAction(title: DJM.shared.getValue(view: "others_view", variable: "email"), style: .default , handler:{ (UIAlertAction)in
            print("texting") } ) )
        alert.addAction(UIAlertAction(title: DJM.shared.getValue(view: "others_view", variable: "chat"), style: .default , handler:{ (UIAlertAction)in
            var str = "Hello"
            let number = "03329282777"
            str = str.addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.urlQueryAllowed))!
            let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(number)&text=\(str)")
            
            if UIApplication.shared.canOpenURL(whatsappURL!) {
                UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
            } else {
                print("whatsapp not intalled")
            } } ) )
        alert.addAction(UIAlertAction(title: DJM.shared.getValue(view: "others_view", variable: "dismiss"), style: .cancel , handler:{ (UIAlertAction)in
            print("dismiss screen") } ) )
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    @IBAction func actionRatings(_ sender: UIButton) {
        let controller = RatingsRouter.createModule()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func actionLogout(_ sender: UIButton) {
        HUM.shared.SetUserLogedOUT()
    }
    @IBAction func actionImagePicker(_ sender: UIButton) {
        ImagePickerManager.shared.openImagePicker(delegate: self)
    }
}

extension OtherViewController: SetupViewController {
    func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavigationWithLogoAndMenuButton()
    }
    
    func setupView() {
        guard let fName = HUM.shared.user?.fName,
            let lName = HUM.shared.user?.LName else {return}
        labelName.attributedText = "\(fName) \(lName)".styled(as: .gibsonRegular_21sp)
        labelEditProfile.attributedText = DJM.shared.getValue(view: "others_view", variable: "edit").styled(as: .gibsonRegular_18sp)
        labelMyCars.attributedText = DJM.shared.getValue(view: "others_view", variable: "mycars").styled(as: .gibsonRegular_18sp)
        labelSupport.attributedText = DJM.shared.getValue(view: "others_view", variable: "support").styled(as: .gibsonRegular_18sp)
        labelRatings.attributedText = DJM.shared.getValue(view: "others_view", variable: "myratings").styled(as: .gibsonRegular_18sp)
        labelLogout.attributedText = DJM.shared.getValue(view: "others_view", variable: "logout").styled(as: .gibsonRegular_18sp)
        labelRating.attributedText = DJM.shared.getValue(view: "others_view", variable: "ratings").styled(as: .gibsonRegular_16sp)
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
}

extension OtherViewController: ImagePickerDelegate {
    func didSelectImage(image: UIImage) {
        self.imageUser.image = image
        
    }
    
    func didCancel() {
        
    }
}
