//
//  RegisterView.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/3/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var registerTitleLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatedPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Setup methods
    func setupUI() {
        setUpLabels()
        setUpTextFields()
        setUpButtons()
    }
    
    // MARK: - Fileprivate methods
    fileprivate func setUpLabels() {
        registerTitleLabel.text = "Sign Up"
    }
    
    fileprivate func setUpTextFields() {
        fullNameTextField.placeholder = "Full name"
        phoneNumberTextField.placeholder = "Your phone number"
        passwordTextField.placeholder = "Password"
        repeatedPasswordTextField.placeholder = "Repeated password"
    }
    
    fileprivate func setUpButtons() {
        signUpButton.setTitle("Sign Up", for: .normal)
    }

}
