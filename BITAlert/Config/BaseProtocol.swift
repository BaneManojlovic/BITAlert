//
//  BaseProtocol.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation


protocol BaseProtocol {
    func handleAPIError(error: APIError)
    func startLoading()
    func stopLoading()
}
