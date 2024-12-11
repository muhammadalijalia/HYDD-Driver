//
//  CongratulationJobPresenter.swift
//  HYDD-driver
//
//  Created Syed Kashan on 24/02/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class CongratulationJobPresenter: CongratulationJobPresenterProtocol, CongratulationJobInteractorOutputProtocol {
    
    var screenType: ScreenTypeCongratulation?

    weak private var view: CongratulationJobViewProtocol?
    var interactor: CongratulationJobInteractorInputProtocol?
    private let router: CongratulationJobWireframeProtocol

    init(interface: CongratulationJobViewProtocol, interactor: CongratulationJobInteractorInputProtocol?, router: CongratulationJobWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func actionOK() {
        guard let screen = self.screenType else {return}
        switch screen {
        case .congratulation:
            self.router.actionOK()
        case .request:
            self.router.showNewJobs()
        }
    }
}
