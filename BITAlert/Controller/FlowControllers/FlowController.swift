//
//  FlowController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/2/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation
import UIKit

class FlowController {

    unowned var currentViewController: UIViewController

    init(currentViewController: UIViewController) {
        self.currentViewController = currentViewController
    }
}
