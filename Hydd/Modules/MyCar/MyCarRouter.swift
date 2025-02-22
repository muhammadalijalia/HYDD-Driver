//
//  MyCarRouter.swift
//  HYDD-driver
//
//  Created Macbook Pro on 18/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class MyCarRouter: MyCarWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MyCarViewController(nibName: nil, bundle: nil)
        let interactor = MyCarInteractor()
        let router = MyCarRouter()
        let presenter = MyCarPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func goBack() {
        guard let nav = self.viewController?.navigationController else {return}
        nav.popViewController(animated: true)
    }

    func gotoDetails(data: [MyCarDetailModel]) {
        guard let nav = self.viewController?.navigationController else {return}
        let controller = MyCarClassDetailRouter.createModule(data)
        nav.pushViewController(controller, animated: true)
    }
    
}
