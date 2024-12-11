//
//  NavigationPopUpProtocols.swift
//  HYDD-driver
//
//  Created Kashan on 12/04/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan


import Foundation

// MARK: Wireframe -
protocol NavigationPopUpWireframeProtocol: class {

}
// MARK: Presenter -
protocol NavigationPopUpPresenterProtocol: class {

    var interactor: NavigationPopUpInteractorInputProtocol? { get set }
}

// MARK: Interactor -
protocol NavigationPopUpInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol NavigationPopUpInteractorInputProtocol: class {

    var presenter: NavigationPopUpInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol NavigationPopUpViewProtocol: class {

    var presenter: NavigationPopUpPresenterProtocol? { get set }

    /* Presenter -> ViewController */
}
