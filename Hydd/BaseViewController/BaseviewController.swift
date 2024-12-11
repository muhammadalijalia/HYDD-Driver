//
//  BaseviewController.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

class BaseViewController: UIViewController {
    var customLoader: UIImageView!
    var fixedLoader: UIImageView!
    let viewBGLoder: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipe.direction = .left
       // swipe.delaysTouchesBegan = true
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc func swipeGesture(_ recognizer: UISwipeGestureRecognizer?) {
        let touches = recognizer?.numberOfTouches
        switch touches {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }
    
    func showLoadingIndicator() {
        hideLoadingIndicator()
        self.viewBGLoder.frame = UIScreen.main.bounds
        self.viewBGLoder.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.viewBGLoder.tag = 1307966
        let originX = UIScreen.main.bounds.width/2
        let originY = UIScreen.main.bounds.height/2  // handling Y
        let frameOuter = CGRect(x: originX - 70/2,
                                y: originY - 70/2,
                                width: 70,
                                height: 70)
        let frameInner = CGRect(x: originX - 60/2,
                                y: originY - 60/2,
                                width: 60,
                                height: 60)

        fixedLoader = UIImageView(frame: frameOuter)
        fixedLoader.backgroundColor = .hyddblue
        fixedLoader.roundCorners(35)
        viewBGLoder.addSubview(fixedLoader)

        customLoader = UIImageView(frame: frameInner)
        customLoader.image = UIImage.init(named: "icon_hydd")
        customLoader.roundCorners(30)
        viewBGLoder.addSubview(customLoader)

        self.viewBGLoder.rotate(imageView: customLoader, aCircleTime: 2)
            // autoresizing mask
        customLoader.translatesAutoresizingMaskIntoConstraints = true
        fixedLoader.translatesAutoresizingMaskIntoConstraints = true

//            // unwrap
        guard let customLoader = customLoader else { return }
        guard let fixedImage = fixedLoader else { return }
//

        viewBGLoder.addConstraint(NSLayoutConstraint(item: fixedImage,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: viewBGLoder,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  multiplier: 1,
                                                  constant: 0))

        viewBGLoder.addConstraint(NSLayoutConstraint(item: fixedImage,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: viewBGLoder,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant: 0))
        viewBGLoder.addConstraint(NSLayoutConstraint(item: customLoader,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: viewBGLoder,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  multiplier: 1,
                                                  constant: 0))

        viewBGLoder.addConstraint(NSLayoutConstraint(item: customLoader,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: viewBGLoder,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant: 0))
        customLoader.startAnimating()
        UIViewController.top().view.addSubview(self.viewBGLoder)

    }
    func hideLoadingIndicator() {
        guard let customLoader = customLoader else { return }
        guard let fixedImage = fixedLoader else { return }
        customLoader.stopAnimating()
        fixedImage.stopAnimating()
        customLoader.removeFromSuperview()
        fixedImage.removeFromSuperview()
        self.viewBGLoder.removeFromSuperview()
        UIApplication.shared.windows.first?.viewWithTag(1307966)?.removeFromSuperview()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}

extension BaseViewController {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
          //  FLEXManager.shared().showExplorer()
        }
    }
}
