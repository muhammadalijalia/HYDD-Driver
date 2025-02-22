//
//  ChatPresenter.swift
//  HYDD-driver
//
//  Created Macbook Pro on 21/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class ChatPresenter: ChatPresenterProtocol, ChatInteractorOutputProtocol {
    
    weak private var view: ChatViewProtocol?
    var interactor: ChatInteractorInputProtocol?
    private let router: ChatWireframeProtocol

    init(interface: ChatViewProtocol, interactor: ChatInteractorInputProtocol?, router: ChatWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func goBack() {
        router.goBack()
    }
    
    func sendNotification(para: [String : Any]) {
        interactor?.sendNotification(para: para)
    }
}
