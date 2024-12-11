//
//  MyCarPresenter.swift
//  HYDD-driver
//
//  Created Macbook Pro on 18/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class MyCarPresenter: MyCarPresenterProtocol, MyCarInteractorOutputProtocol {
    
    var myCars: MyCarModel?
    var classes: [MyCarDetailModel]?
    
    weak private var view: MyCarViewProtocol?
    var interactor: MyCarInteractorInputProtocol?
    private let router: MyCarWireframeProtocol

    init(interface: MyCarViewProtocol, interactor: MyCarInteractorInputProtocol?, router: MyCarWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func goBack() {
        router.goBack()
    }
    
    func goto(index: IndexPath) {
        guard let type = self.classes?[index.row],
        let data = HCM.shared.getCarsOfMyClass(vehicleClass: type.model) else {return}
        router.gotoDetails(data: data)
    }
    
    func setData(data: MyCarModel) {
        myCars = data
        classes = HCM.shared.getCarClass()
        view?.reloadData()
    }

    func getMyCars() {
        guard let myCars = MyCarManager.shared.myCars else {return}
        self.setData(data: myCars)
    }

}
