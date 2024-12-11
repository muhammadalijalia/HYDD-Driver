//
//  Result.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

public struct Result<T> {
    public let successResponse: T?
    public let failureResponse: Error?
    
    init(success: T) {
        successResponse = success
        failureResponse = nil
    }
    
    init(failure: Error) {
        successResponse = nil
        failureResponse = failure
    }
}
