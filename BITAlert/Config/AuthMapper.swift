//
//  AuthMapper.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation
import Alamofire

class AuthMapper: Mapper {
    
    // MARK: - Properties
    var authAPI: AuthAPI
    
    // MARK: - Initialization
    override init() {
        self.authAPI = AuthAPI()
    }
    
    // MARK: - Typealias properties
    typealias RegisterSuccess = (_ response: RegisterResponseModel) -> Void
    
    // MARK: - Methods
    @discardableResult
    func registerUser(
        model: RegisterRequestModel,
        success: @escaping RegisterSuccess,
        failure: @escaping BaseAPI.APIRequestFailure
        ) -> Request? {
        return authAPI.registerUser(
            model: model,
            success: { (_ registerModel: RegisterResponseModel) in
                success(registerModel)
        }, failure: failure)
    }
}
