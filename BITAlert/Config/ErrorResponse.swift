//
//  ErrorResponse.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//
import Foundation

struct ErrorResponse: Codable {
    var resourceerror: ResourceError?
}

struct ResourceError: Codable {
    var status: String?
    var timestamp: String?
    var message: String?
    var debugMessage: String?
}
