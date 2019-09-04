//
//  AuthentificationFlowController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class AuthentificationFlowController: FlowController {

    func goToLogin() {
        let loginVC = StoryboardScene.Authentification.loginViewController.instantiate()
        loginVC.presenter = LoginPresenter()
        currentViewController.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func goToRegister() {
        let registerVC = StoryboardScene.Authentification.registerViewController.instantiate()
        registerVC.presenter = RegisterPresenter()
        currentViewController.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func goToActivationCode() {
        let activationCodeVC = StoryboardScene.Authentification.activationCodeViewController.instantiate()
        activationCodeVC.presenter = ActivationCodePresenter()
        currentViewController.navigationController?.pushViewController(activationCodeVC, animated: true)
    }
}
