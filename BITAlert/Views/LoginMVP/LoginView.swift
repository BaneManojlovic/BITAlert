//
//  LoginView.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class LoginView: UIView {

    // MARK: - Outlets
    
    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    // MARK: - Setup methods
    func setupUI() {
        setUpLabels()
        setUpTextFields()
        setUpButtons()
    }
    
    // MARK: - Fileprivate methods
    fileprivate func setUpLabels() {
        loginTitleLabel.text = "Login"
    }
    
    fileprivate func setUpTextFields() {
        usernameTextField.placeholder = "Username or email"
        passwordTextField.placeholder = "Password"
    }
    
    fileprivate func setUpButtons() {
        loginButton.setTitle("Login", for: .normal)
        signUpButton.setTitle("Sign Up", for: .normal)
    }
    
    
}
