//
//  SplashView.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class SplashView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: - Setup methods
    func setupUI() {
        logoImageView.image = Asset.splashIcon.image
    }

}
