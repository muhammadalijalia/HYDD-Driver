//
//  NavigationRouter.swift
//  HYDD-driver
//
//  Created Macbook Pro on 11/04/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class NavigationRouter: NavigationWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = NavigationViewController(nibName: nil, bundle: nil)
        let interactor = NavigationInteractor()
        let router = NavigationRouter()
        let presenter = NavigationPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func addPressed() {
        guard let nav = self.viewController?.navigationController,
            let view = self.viewController as? NavigationViewController else { return }
        let slider = SlideInPresentationManager()
        let controller = NavigationPopUpRouter.createModule(view)
        slider.disableCompactHeight = true
        slider.direction = .bottom
        slider.height = 1
        slider.yAxis = 0
        slider.isTapEnabled = false
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = slider
        nav.present(controller, animated: true, completion: nil)
    }
    
    func gotoInProgress() {
        Bootstrapper.showTabbar(selectedIndex: 1)
    }
    
}
