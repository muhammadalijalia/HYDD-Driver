//
//  Error.swift
//  Sippy
//
//  Created by Syed Kashan on 10/14/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

enum SippyError: Error {
    case none
    case empty
}

extension SippyError: LocalizedError {
    public var errorDescription: String? {
        let sharedDjm = DJM.shared
        switch self {
        case .none:
            return NSLocalizedString("", comment: "")
        case .empty:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "empty"), comment: "Empty Textfield")
        }
    }
}

enum TfError: Error {
    case none
    case empty
    case emptyFullName
    case emptyFirstName
    case emptylastName
    case emptyEmail
    case emptyPassword
    case emptyPhoneNumber
    case emptyCountry
    case emptyCardName
    case emptyPromo
    case emptyCardNumber
    case emptyCVV
    case emptyExpiry
    case invalidCardNumber
    case invalidName
    case invalidEmail
    case invalidPassword
    case invalidCountry
    case invalidPhoneNumber
    case invalidPromo
    case invalidFName
    case invalidLName
    case invalidCVV
    case invalidExpiryExpired
    case invalidExpiry
}

extension TfError: LocalizedError {
    public var errorDescription: String? {
        let sharedDjm = DJM.shared
        switch self {
        case .none:
            return NSLocalizedString("", comment: "")
        case .empty:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "empty"), comment: "Empty Textfield")
        case .invalidName:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_name"), comment: "Invalid Name")
        case .invalidEmail:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_email"), comment: "Invalid Email")
        case .invalidPassword:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_password"), comment: "Invalid Password")
        case .invalidCountry:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalidCountry"), comment: "Invalid Country")
        case .invalidPhoneNumber:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalidPhoneNumber"), comment: "Invalid Phone Number")
        case .invalidPromo:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_promo"), comment: "Invalid Promo Code")
        case .invalidFName:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_fname"), comment: "Invalid First Name")
        case .invalidLName:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_lname"), comment: "Invalid Last Name")
        case .emptyFirstName:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "first_name"), comment: "Empty First Name")
        case .emptylastName:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "last_name"), comment: "Empty Last Name")
        case .emptyEmail:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "email"), comment: "Empty Email Name")
        case .emptyPassword:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "password"), comment: "Empty Password Name")
        case .emptyCountry:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "country"), comment: "Empty Country")
        case .emptyPhoneNumber:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "phone_number"), comment: "Empty Phone Number")
        case .emptyFullName:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "full_name"), comment: "Empty Full Name")
        case .emptyPromo:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "promo"), comment: "Empty Promo")
        case .emptyCardNumber:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "card_number"), comment: "Empty Promo")
        case .invalidCardNumber:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_card_number"), comment: "Empty Card Number")
        case .emptyCVV:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "cvv"), comment: "Empty CVV")
        case .emptyExpiry:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "expiry"), comment: "Empty Expiry")
        case .invalidCVV:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_cvv"), comment: "Error CVV")
        case .invalidExpiryExpired:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_expiry_expired"), comment: "Error Expiry")
        case .invalidExpiry:
            return NSLocalizedString(sharedDjm.getValue(view: "error_msgs", variable: "invalid_expiry"), comment: "Error Expiry")
        case .emptyCardName:
            return NSLocalizedString(sharedDjm.getValue(view: "empty_field_msg", variable: "card_name"), comment: "Empty Card Name")
        }
    }
}
