//
//  SetUpProtocols.swift
//  Sippy
//
//  Created by Syed Kashan on 10/14/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

protocol SetupViewController {
    func setupNavigation()
    func setupView()
    func networkRequest()
}

protocol SetupCell {
    func configureCell<T>(object: T)
}

protocol SetupHeader {
    func configuereHeader<T>(object: T, title: String?)
}
