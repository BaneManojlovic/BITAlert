//
//  RegisterPresenter.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/3/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation

protocol RegisterDelegate: class {
    
}

class RegisterPresenter {
    
    weak var delegate: RegisterDelegate!
    
    init() {}
    
    func attachView(view: RegisterDelegate) {
        delegate = view
    }
    
    func detachView() {
        delegate = nil
    }
}
