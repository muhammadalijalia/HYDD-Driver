//
//  RatingsPresenter.swift
//  HYDD-driver
//
//  Created Syed Kashan on 30/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class RatingsPresenter: RatingsPresenterProtocol, RatingsInteractorOutputProtocol {

    weak private var view: RatingsViewProtocol?
    var interactor: RatingsInteractorInputProtocol?
    private let router: RatingsWireframeProtocol

    init(interface: RatingsViewProtocol, interactor: RatingsInteractorInputProtocol?, router: RatingsWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
