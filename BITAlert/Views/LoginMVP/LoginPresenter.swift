//
//  LoginPresenter.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation

protocol LoginDelegate: class {
    
}

class LoginPresenter {
    
    weak var delegate: LoginDelegate!
    
    func attachView(view: LoginDelegate) {
        delegate = view
    }
    
    func detachView() {
        delegate = nil
    }
}
