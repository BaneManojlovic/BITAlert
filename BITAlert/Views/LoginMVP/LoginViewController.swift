//
//  LoginViewController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenter!

    private var loginView: LoginView! {
        loadViewIfNeeded()
        return view as? LoginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTargets() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    func setupUI() {
        loginView.setupUI()
    }
    
    func setupTargets() {
        loginView.loginButton.addTarget(self, action: #selector(openHomeScreen), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(openRegisterScreen), for: .touchUpInside)
    }

    // MARK: - Methods
    @objc func openHomeScreen() {
        print("Login tapped ...")
    }
    
    @objc func openRegisterScreen() {
        print("Signup tapped ...")
    }
}
