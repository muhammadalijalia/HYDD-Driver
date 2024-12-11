//
//  UIViewControllerExtention.swift
//  Sippy
//
//  Created by Syed Kashan on 10/1/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit

let themeColor = UIColor(red:0.23, green:0.80, blue:0.88, alpha:1.0)
let textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
let themeColorDark = UIColor(hexString: "#0197AC")
let themeColorRed = UIColor(hexString: "#BC0000")

extension UIViewController {
    enum typeButton {
        case accept, cancel, missionCancelled
    }
    
    func giveBtnCornerRadiusWithTheDarkBackGround(view : UIView , btn : UIButton, type: typeButton = .accept) {
        view.layer.cornerRadius = 6
        btn.layer.cornerRadius = 6
        view.clipsToBounds = true
        btn.clipsToBounds = true
        switch type {
        case .accept:
            btn.backgroundColor = .hyddblue
            view.backgroundColor = .hyddblue
        case .cancel:
            btn.backgroundColor = .hyddRed
            view.backgroundColor = .hyddRed
        case .missionCancelled:
            btn.backgroundColor = .lightGray
            view.backgroundColor = .lightGray
        }
        
        btn.setTitleColor(textColor, for: .normal)
        
    }
    
    func giveTextFieldCornerRadius(view:UIView , textField : UITextField){
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        textField.clipsToBounds = true
    }
    
    func giveBtnCornerRadiusWithoutDarkBackGround(view : UIView , btn : UIButton) {
        view.layer.cornerRadius = 6
        btn.layer.cornerRadius = 6
        view.clipsToBounds = true
        btn.clipsToBounds = true
        view.backgroundColor = themeColor
        btn.setTitleColor(textColor, for: .normal)
        btn.backgroundColor = UIColor.clear
    }
    
    func setStatusBarColor(color: UIColor) {
           UIApplication.shared.statusBarUIView?.backgroundColor = color
        DispatchQueue.main.async {
               self.setNeedsStatusBarAppearanceUpdate()
           }
       }
    func whenTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: self, action: #selector(hideKeyboard))
        doneBarButton.setTitleTextAttributes(
            [   NSAttributedString.Key.font: UIFont(name: Fonts.avenirRegular, size: 15)!,
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ], for: .normal)
        doneBarButton.setTitleTextAttributes(
            [   NSAttributedString.Key.font: UIFont(name: Fonts.avenirRegular, size: 15)!,
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ], for: .selected)
        keyboardToolbar.items = [flexBarButton, doneBarButton]
    }
    static func top() -> UIViewController {
        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else { fatalError("No view controller present in app?") }
           var result = rootViewController
           while let vc = result.presentedViewController {
               result = vc
           }
           return result
       }
    
    func setTitle(_ title: String) {
        
        if self.navigationController != nil {
            
            let titleLabel = UILabel(frame: CGRect.zero)
            titleLabel.text = title
            titleLabel.numberOfLines = 1
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.minimumScaleFactor = 0.2
            let keyColor = NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue)
            let color = UIColor.black
            let keyFont = NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)
            guard let font = UIFont(name: Fonts.avenirBold, size: 14) else {return }
            let keyParagraph = NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.5
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.alignment = .center
            let myAttribute: [NSAttributedString.Key: Any] = [keyColor: color,
                                                              keyFont: font,
                                                              keyParagraph: paragraphStyle]
            titleLabel.attributedText = NSAttributedString(string: titleLabel.text!, attributes: myAttribute)
            titleLabel.sizeToFit()
            self.navigationItem.titleView = titleLabel
        }
    }
    
    func setNavBarColor(_ color: UIColor) {
        //Unwrap navigationController
        guard let navigationController = self.navigationController else { return }
        // To change background colour.
        navigationController.navigationBar.barTintColor = color
        // To change colour of tappable items.
        navigationController.navigationBar.tintColor = color
        // To control navigation bar's translucency.
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.backgroundColor = color
    }

    func setNavigationWithLogoAndBackButton(_ shadow: Bool = false) -> UIButton {
        
        if self.navigationController != nil {
            self.setStatusBarColor(color: .clear)
            self.setNavBarColor(UIColor.white)
            let buttonMenu: UIButton = UIButton.init(type: .custom)
            let image = UIImage(named: "icon-dark-back")?.withRenderingMode(.alwaysOriginal)
            buttonMenu.setImage(image, for: UIControl.State.normal)
            buttonMenu.setImage(image, for: UIControl.State.highlighted)
            buttonMenu.setImage(image, for: UIControl.State.selected)
            buttonMenu.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            let buttonBackBar = UIBarButtonItem(customView: buttonMenu)
            
            let logo = UIImage(named: "icon_title")?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.titleView = UIImageView(image: logo)
            self.navigationItem.leftBarButtonItem = buttonBackBar
            return buttonMenu
        }
        return UIButton()
    }
    
    func setNavigationWithLogoAndCrossButton(_ shadow: Bool = false) -> UIButton {
        
        if self.navigationController != nil {
            self.setStatusBarColor(color: .clear)
            self.setNavBarColor(UIColor.white)
            let buttonMenu: UIButton = UIButton.init(type: .custom)
            let image = UIImage(named: "icon_cross")?.withRenderingMode(.alwaysOriginal)
            buttonMenu.setImage(image, for: UIControl.State.normal)
            buttonMenu.setImage(image, for: UIControl.State.highlighted)
            buttonMenu.setImage(image, for: UIControl.State.selected)
            buttonMenu.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            let buttonBackBar = UIBarButtonItem(customView: buttonMenu)
            
            let logo = UIImage(named: "icon_title")?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.titleView = UIImageView(image: logo)
            self.navigationItem.leftBarButtonItem = buttonBackBar
            return buttonMenu
        }
        return UIButton()
    }
    
    func setNavigationWithLogoAndMenuButton(_ shadow: Bool = false) {
        
        if self.navigationController != nil {
            self.setStatusBarColor(color: .clear)
            self.setNavBarColor(UIColor.white)
            let logo = UIImage(named: "icon_title")?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.titleView = UIImageView(image: logo)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    static func isChatViewControllerAtTop() -> ChatViewController? {
        guard let tabbar = UIViewController.top() as? HyddTabbarVC,
            let nav = tabbar.selectedViewController as? UINavigationController,
            let chatVC = nav.topViewController as? ChatViewController else {
                return nil
        }
        return chatVC
    }
}

