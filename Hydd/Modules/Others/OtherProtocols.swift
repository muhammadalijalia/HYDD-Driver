//
//  OtherProtocols.swift
//  HYDD-driver
//
//  Created Syed Kashan on 04/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import Foundation

// MARK: Wireframe -
protocol OtherWireframeProtocol: class {

}
// MARK: Presenter -
protocol OtherPresenterProtocol: class {

    var interactor: OtherInteractorInputProtocol? { get set }
}

// MARK: Interactor -
protocol OtherInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol OtherInteractorInputProtocol: class {

    var presenter: OtherInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol OtherViewProtocol: class {

    var presenter: OtherPresenterProtocol? { get set }

    /* Presenter -> ViewController */
}
