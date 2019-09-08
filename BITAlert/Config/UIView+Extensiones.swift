//
//  UIView+Extensiones.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow() {
        layer.shadowColor = Constants.shadowColor.cgColor
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowOpacity = Constants.shadowOpacity
        layer.masksToBounds = false
    }

}
