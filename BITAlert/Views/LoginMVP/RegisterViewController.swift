//
//  RegisterViewController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var presenter: RegisterPresenter!
    
    private var registerView: RegisterView! {
        loadViewIfNeeded()
        return view as? RegisterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        registerView.setupUI()
        
    }


}
