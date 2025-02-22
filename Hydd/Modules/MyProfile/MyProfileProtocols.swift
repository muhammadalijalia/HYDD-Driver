//
//  MyProfileProtocols.swift
//  HYDD-driver
//
//  Created Macbook Pro on 15/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import Foundation
import UIKit

// MARK: Wireframe -
protocol MyProfileWireframeProtocol: class {
    func gotoEmailVerify()
    func gotoPassword()
    func gotoCarSelect()

}
// MARK: Presenter -
protocol MyProfilePresenterProtocol: class {

    var interactor: MyProfileInteractorInputProtocol? { get set }
    
    var phone: String? {get set}
    var carPlate: String? {get set}
    var image: String? {get set}
    
    func gotoEmailVerify()
    func gotoPassword()
    func gotoCarSelect()
    func updateProfile()
    func showPicker()
    
    func set(phone: String)
    func set(carPlate: String)
    func set(image: String)
}

// MARK: Interactor -
protocol MyProfileInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func successUpdate()
    func failedUpdate(error: String)
}

protocol MyProfileInteractorInputProtocol: class {

    var presenter: MyProfileInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
    func updateProfile(para: [String: Any])
}

// MARK: View -
protocol MyProfileViewProtocol: class {

    var presenter: MyProfilePresenterProtocol? { get set }

    func setNewImage(image: UIImage)
    func showLoader()
    func hideLoader()
    
    /* Presenter -> ViewController */
}
