//
//  RegisterViewController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class RegisterViewController: NavigationBaseViewController {
    
    // MARK: - Properties
    var presenter: RegisterPresenter!
    
    // MARK: - Private properties
    lazy private var flowController = AuthentificationFlowController(currentViewController: self)
    private var registerView: RegisterView! {
        loadViewIfNeeded()
        return view as? RegisterView
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Setup methods
    func setupUI() {
        registerView.setupUI()
        
    }
    
    func setupTargets() {
        registerView.signUpButton.addTarget(self, action: #selector(openActivationCodeScreen), for: .touchUpInside)
    }
    
    // MARK: - Private handlers
    @objc func openActivationCodeScreen() {
        debugPrint("Open Activation code screen...")
        flowController.goToActivationCode()
    }
    
}

// MARK: - Validation handler
extension RegisterViewController {
    
    private func validationHandler(errors: RegisterRequestModel.ValidationError) {
        switch errors {
        case .fullNameEmpty, .fullNameInvalid:
            registerView.fullNameTextField.text = errors.localizedDescription
        case .phoneNoEmpty, .phoneNoInvalid:
            registerView.phoneNumberTextField.text = errors.localizedDescription
        case .passwordEmpty, .passwordInvalid:
            registerView.passwordTextField.text = errors.localizedDescription
        case .repeatPasswordEmpty, .repeatPasswordInvalid:
            registerView.repeatedPasswordTextField.text = errors.localizedDescription
        case .passwordsDontMatch:
            registerView.passwordTextField.text = errors.localizedDescription
            registerView.repeatedPasswordTextField.text = errors.localizedDescription
        case .unknown:
            break
        }
    }
}

// MARK: - Conforming to RegisterDelegate protocol
extension RegisterViewController: RegisterDelegate {

    func registerSuccess(user: RegisterResponseModel, fullName: String, password: String, phoneNo: String, repeatedPassword: String) {
        self.showOkAlert(message: "You successfully registered!")
    }
    
    func registerValidationError(error: RegisterRequestModel.ValidationError) {
        self.showOkAlert(message: error.localizedDescription)
        return validationHandler(errors: error)
    }
    
    
}
