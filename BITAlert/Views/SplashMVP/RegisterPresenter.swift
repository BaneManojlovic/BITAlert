//
//  RegisterPresenter.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/3/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation

protocol RegisterDelegate: class, BaseProtocol {
    func registerValidationError(error: RegisterRequestModel.ValidationError)
    func registerSuccess(user: RegisterResponseModel, fullName: String, password: String,
                         phoneNo: String, repeatedPassword: String)
}

class RegisterPresenter {
    
    // MARK: - Properties
    weak var delegate: RegisterDelegate?
    
    // MARK: - Private properties
    private var authMapper = AuthMapper()
    
    // MARK: - Initialization
    init() {}
    
    // MARK: - Methods
    func attachView(view: RegisterDelegate) {
        delegate = view
    }
    
    func detachView() {
        delegate = nil
    }
    
    func register(registerModel: RegisterRequestModel) {
        delegate?.startLoading()
        do {
            try registerModel.validate()
            authMapper.registerUser(
                model: registerModel,
                success: { [weak self] (response) in
                    self?.delegate?.stopLoading()
                    self?.delegate?.registerSuccess(user: response,
                                                    fullName: registerModel.fullName ?? "",
                                                    password: registerModel.password ?? "",
                                                    phoneNo: registerModel.phoneNo ?? "",
                                                    repeatedPassword: registerModel.repeatedPassword ?? "")
                }, failure: { [weak self] (error) in
                    self?.delegate?.handleAPIError(error: error)
            })
        } catch let error as RegisterRequestModel.ValidationError {
            delegate?.stopLoading()
            delegate?.registerValidationError(error: error)
        } catch {
            debugPrint(error)
        }
    }
}
