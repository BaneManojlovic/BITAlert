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
        let loginViewController = StoryboardScene.Authentification.loginViewController.instantiate()
        loginViewController.presenter = LoginPresenter()
        currentViewController.navigationController?.pushViewController(loginViewController, animated: true)
    }
}
