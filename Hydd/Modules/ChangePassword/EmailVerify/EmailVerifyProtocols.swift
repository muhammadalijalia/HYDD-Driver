//
//  EmailVerifyProtocols.swift
//  HYDD-driver
//
//  Created Syed Kashan on 01/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import Foundation

// MARK: Wireframe -
protocol EmailVerifyWireframeProtocol: class {
    func goBack()
}
// MARK: Presenter -
protocol EmailVerifyPresenterProtocol: class {

    var interactor: EmailVerifyInteractorInputProtocol? { get set }
    
    var email: String? {get set}
    
    func set(email: String)
    func update()
}

// MARK: Interactor -
protocol EmailVerifyInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    
    func successChange()
    func failedChange()
}

protocol EmailVerifyInteractorInputProtocol: class {

    var presenter: EmailVerifyInteractorOutputProtocol? { get set }
    
    func update(email: String)

    /* Presenter -> Interactor */
}

// MARK: View -
protocol EmailVerifyViewProtocol: class {

    var presenter: EmailVerifyPresenterProtocol? { get set }
    
    func showLoader()
    func hideLoader()
    func dismissView()

    /* Presenter -> ViewController */
}
