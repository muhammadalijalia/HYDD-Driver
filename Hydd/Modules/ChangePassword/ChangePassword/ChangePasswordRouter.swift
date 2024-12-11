//
//  ChangePasswordRouter.swift
//  HYDD-driver
//
//  Created Syed Kashan on 01/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class ChangePasswordRouter: ChangePasswordWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ChangePasswordViewController(nibName: nil, bundle: nil)
        let interactor = ChangePasswordInteractor()
        let router = ChangePasswordRouter()
        let presenter = ChangePasswordPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func gotoVerify(old: String) {
        guard let nav = viewController?.navigationController else {return}
        let newPassword = NewPasswordRouter.createModule(oldPassword: old)
        nav.pushViewController(newPassword, animated: true)
    }
    
}
