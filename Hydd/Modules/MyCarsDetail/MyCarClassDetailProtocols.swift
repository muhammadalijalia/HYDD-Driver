//
//  MyCarClassDetailProtocols.swift
//  HYDD-driver
//
//  Created Macbook Pro on 20/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import Foundation

// MARK: Wireframe -
protocol MyCarClassDetailWireframeProtocol: class {
    func goBack()
    func goto()
}
// MARK: Presenter -
protocol MyCarClassDetailPresenterProtocol: class {

    var interactor: MyCarClassDetailInteractorInputProtocol? { get set }
    
    var carData: [MyCarDetailModel]? {get set}
    
    func goBack()
    func goto(index: IndexPath)
}

// MARK: Interactor -
protocol MyCarClassDetailInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol MyCarClassDetailInteractorInputProtocol: class {

    var presenter: MyCarClassDetailInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol MyCarClassDetailViewProtocol: class {

    var presenter: MyCarClassDetailPresenterProtocol? { get set }
    /* Presenter -> ViewController */
}
