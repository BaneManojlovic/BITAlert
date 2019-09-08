//
//  UIViewController+Alerts.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showOkAlert(
        title: String? = nil,
        message: String,
        confirmation: (() -> Void)? = nil,
        completion: (() -> Void)? = nil) {
        
        let okAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        okAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            confirmation?()
        }))
        
        self.present(okAlert, animated: true, completion: completion)
    }
    
    /// Call this function to show alert when there is no internet connection. Default options
    /// are `Settings` and `Cancel` and if you provide tryAgainHandler closure additional `Try again` button is added.
    ///
    /// - Parameter tryAgainHandler: Closure which executes when user taps on `Try again` button.
    /// - Returns: Presented alert.
    @discardableResult
    func showNoInternetDialog(tryAgainHandler: (() -> Void)?) -> UIAlertController {
        
        let alert = UIAlertController(title: L10n.alertTitleNoInternet,
                                      message: L10n.alertMessageNoInternet,
                                      preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: L10n.buttonTitleSettings, style: .default) { (_) in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            guard UIApplication.shared.canOpenURL(settingsURL) else { return }
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
        alert.addAction(settingsAction)
        
        if tryAgainHandler != nil {
            let tryAgainAction = UIAlertAction(title: L10n.buttonTitleTryAgain, style: .default) { (_) in
                tryAgainHandler?()
            }
            alert.addAction(tryAgainAction)
        }
        
        let cancelAction = UIAlertAction(title: L10n.buttonTitleCancel, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
        return alert
    }
}
