//
//  AuthAPI.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation
import Alamofire

class AuthAPI: BaseAPI {
    
    // MARK: - Private properties
    private let headers: [String: String] = ["language": LanguageHelper.getLanguage()]
    private enum Endpoint {
        static let register = "/krizio/WS_SignUP"
    }
    
    // MARK: - TypeAlias Properties
    typealias RegisterSuccess = (_ response: RegisterResponseModel) -> Void
    
    // MARK: - Methods
    @discardableResult
    func registerUser(
        model: RegisterRequestModel,
        success: @escaping RegisterSuccess,
        failure: @escaping BaseAPI.APIRequestFailure
        ) -> Request? {
        return sendPOSTRequest(
            endpoint: Endpoint.register,
            model: model,
            headers: headers,
            success: { (_ registerModel: RegisterResponseModel) in
                success(registerModel)
        }, failure: failure)
    }
}
