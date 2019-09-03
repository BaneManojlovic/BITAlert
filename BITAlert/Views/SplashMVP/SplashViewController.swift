//
//  SplashViewController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/1/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, SplashPresenterDelegate {
    
    lazy private var flowController = AuthentificationFlowController(currentViewController: self)
    var presenter = SplashPresenter()
    
    private var splashScreenView: SplashView! {
        loadViewIfNeeded()
        return view as? SplashView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self
        setupUI()
        checkAuthorizationStatus()
    }
    

    func setupUI() {
        splashScreenView.setupUI()
    }

    @objc func checkAuthorizationStatus() {
        flowController.goToLogin()
    }
    
}
