//
//  MyCarProtocols.swift
//  HYDD-driver
//
//  Created Macbook Pro on 18/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import Foundation

// MARK: Wireframe -
protocol MyCarWireframeProtocol: class {
    func goBack()
    func gotoDetails(data: [MyCarDetailModel])
}
// MARK: Presenter -
protocol MyCarPresenterProtocol: class {

    var interactor: MyCarInteractorInputProtocol? { get set }
    
    var myCars: MyCarModel? {get set}
    var classes: [MyCarDetailModel]? {get set}
    
    func getMyCars()
    
    func goBack()
    func goto(index: IndexPath)
    
}

// MARK: Interactor -
protocol MyCarInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol MyCarInteractorInputProtocol: class {

    var presenter: MyCarInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol MyCarViewProtocol: class {

    var presenter: MyCarPresenterProtocol? { get set }
    
    func reloadData()
    /* Presenter -> ViewController */
}
