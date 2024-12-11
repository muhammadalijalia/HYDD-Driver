//
//  ForgotPasswordProtocols.swift
//  HYDD-driver
//
//  Created Syed Kashan on 25/01/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import Foundation

// MARK: Wireframe -
protocol ForgotPasswordWireframeProtocol: class {
    func goBack()
}
// MARK: Presenter -
protocol ForgotPasswordPresenterProtocol: class {

    var interactor: ForgotPasswordInteractorInputProtocol? { get set }
    var email: String? {get set}
    
    func set(email: String)
    func goBack()
    func reset()
}

// MARK: Interactor -
protocol ForgotPasswordInteractorOutputProtocol: class {

    func successRequest(message: String)
    func failedRequest(message: String)
    /* Interactor -> Presenter */
}

protocol ForgotPasswordInteractorInputProtocol: class {

    var presenter: ForgotPasswordInteractorOutputProtocol? {get set}
    func reset(email: String)
    /* Presenter -> Interactor */
}

// MARK: View -
protocol ForgotPasswordViewProtocol: class {

    var presenter: ForgotPasswordPresenterProtocol? {get set}

    func setEmailStatus(error: TfError, status: TFStatus)
    func showLoader()
    func hideLoader()
    /* Presenter -> ViewController */
}
