//
//  RegisterViewController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
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
