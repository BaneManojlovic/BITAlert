//
//  RegisterModel.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation

struct RegisterRequestModel: Codable {
    
    var fullName: String?
    var password: String?
    var phoneNo: String?
    var repeatedPassword: String?
    
    func validate() throws {
        
        if let name = fullName {
            if name.isEmpty {
                throw ValidationError.fullNameEmpty
            }
        } else {
            throw ValidationError.fullNameEmpty
        }
        
        if let phoneNumber = phoneNo {
//            if !StringHelper.isPhoneNumberValid(phoneNumber) {
//                throw ValidationError.phoneNoInvalid
//            }
        } else {
            throw ValidationError.phoneNoEmpty
        }
        
        if let password = password {
//            if !StringHelper.isPasswordValid(password) {
//                throw ValidationError.passwordInvalid
//            }
        } else {
            throw ValidationError.passwordEmpty
        }
        
        if let password = password, let confimPassword = repeatedPassword {
//            if !ValidationHelper.repeatPasswordValidation(password, confimPassword) {
//                throw ValidationError.passwordsDontMatch
//            }
        }
        
    }
    
    enum ValidationError: Error {
        case fullNameEmpty
        case fullNameInvalid
        case phoneNoEmpty
        case phoneNoInvalid
        case passwordEmpty
        case passwordInvalid
        case repeatPasswordEmpty
        case repeatPasswordInvalid
        case passwordsDontMatch
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .fullNameEmpty: return "Full name can not be empty"
            case .fullNameInvalid: return "Full name is in invalid format"
            case .phoneNoEmpty: return "Phone number is empty"
            case .phoneNoInvalid: return "Phone number is in invalid format"
            case .passwordEmpty: return "Password is empty"
            case .passwordInvalid: return "Password is in invalid format"
            case .repeatPasswordEmpty: return "Repeat password is empty"
            case .repeatPasswordInvalid: return "Repeat password is invalid format"
            case .passwordsDontMatch: return "Password and repeated password don't match"
            case .unknown: return "Unknown validation error"
            }
        }
    }
    
}

struct RegisterResponseModel: Decodable {
    
    var message: String
    var remainingAttempts: Int
    var remainingAttemptsMessage: String
    var temporaryId: String

}
