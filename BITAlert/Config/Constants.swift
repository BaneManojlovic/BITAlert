//
//  Constants.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

struct Constants {
    
    // MARK: - For Progress Hud
    static let shadowRadius: CGFloat = 8
    static let shadowOffset = CGSize(width: 0, height: 4)
    static let shadowOpacity: Float = 1
    static let shadowColor = UIColor(white: 0, alpha: 0.1)

    // MARK: - For connection to server
    static let baseURL = "http://138.201.32.208:9595/v2/api-docs"
}
