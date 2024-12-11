//
//  MyJobsRouter.swift
//  HYDD-driver
//
//  Created Syed Kashan on 06/02/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class MyJobsRouter: MyJobsWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MyJobsViewController(nibName: nil, bundle: nil)
        let interactor = MyJobsInteractor()
        let router = MyJobsRouter()
        let presenter = MyJobsPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func gotoStartJob(data: CarSummaryModel) {
        guard let nav = self.viewController?.navigationController else {return}
        let controller = StartJobRouter.createModule(.progress, dataList: data)
        nav.pushViewController(controller, animated: true)
    }
    
}
