//
//  SplashPresenter.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation

protocol SplashPresenterDelegate: class {
    
}

class SplashPresenter {
    
    weak var delegate: SplashPresenterDelegate?
    
    init() { }
    
    func attachView(view: SplashPresenterDelegate) {
    delegate = view
    }
    
    func detachView() {
        delegate = nil
    }
}
