//
//  ActivationCodePresenter.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation

protocol ActivationCodeDelegate: class {
    
}

class ActivationCodePresenter {
    
    weak var delegate: ActivationCodeDelegate!
    
    init() {}
    
    func attachView(view: ActivationCodeDelegate) {
        delegate = view
    }
    
    func detachView() {
        delegate = nil
    }
}
