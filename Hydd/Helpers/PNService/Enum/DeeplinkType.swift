//
//  DeeplinkType.swift
//  Hydd
//
//  Created Macbook Pro on 21/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.

import Foundation

enum DeeplinkType {
    case missionRegistered(missionId: Int)
    case chatMessage(clientId: Int, clientName: String, clientImage: String)
}
