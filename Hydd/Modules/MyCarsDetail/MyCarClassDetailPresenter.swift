//
//  MyCarClassDetailPresenter.swift
//  HYDD-driver
//
//  Created Macbook Pro on 20/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class MyCarClassDetailPresenter: MyCarClassDetailPresenterProtocol, MyCarClassDetailInteractorOutputProtocol {
    
    var carData: [MyCarDetailModel]?

    weak private var view: MyCarClassDetailViewProtocol?
    var interactor: MyCarClassDetailInteractorInputProtocol?
    private let router: MyCarClassDetailWireframeProtocol

    init(interface: MyCarClassDetailViewProtocol, interactor: MyCarClassDetailInteractorInputProtocol?, router: MyCarClassDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func goBack() {
        router.goBack()
    }
    
    func goto(index: IndexPath) {
        guard let data = carData?[index.row] else {return}
        router.goto()
        NotificationCenter.default.post(name: APPCONSTANT.NOTIFICATIONS.updateCar, object: nil, userInfo: ["name": "\(data.brand) \(data.numberPlate)"])
    }
}
