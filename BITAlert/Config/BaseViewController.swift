//
//  BaseViewController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Alamofire

class BaseViewController: UIViewController {

    // MARK: - Private Properties
    private var progressHUD: MBProgressHUD?
    typealias NoInternetHandler = () -> Void
    private var noInternetHandler: NoInternetHandler?
    private var noInternetAlert: UIAlertController?
    private let networkReachability = NetworkReachabilityManager()
    
    // MARK: - Methods
    func initPresenter() {
        preconditionFailure("This Methods needs to be overrided")
    }
    
    func showProgressHUD(_ show: Bool) {
        if show {
            if progressHUD == nil {
                progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
                progressHUD?.bezelView.style = .solidColor
                progressHUD?.bezelView.addShadow()
                progressHUD?.bezelView.layer.masksToBounds = false
                progressHUD?.removeFromSuperViewOnHide = true
            }
        } else {
            progressHUD?.hide(animated: true)
            progressHUD = nil
        }
    }
    
    private func handleUnauthorizadError() {
        self.dismiss(animated: false, completion: {
            debugPrint("handle logout method")
        })
    }
    
    private func handleNoInternet(handler: NoInternetHandler?) {
        noInternetHandler = handler
        noInternetAlert = showNoInternetDialog(tryAgainHandler: { [unowned self] in
            self.noInternetHandler?()
            self.noInternetHandler = nil
            self.networkReachability?.stopListening()
        })
        setConnectionListener()
    }
    
    private func setConnectionListener() {
        networkReachability?.listener = { [weak self] status in
            guard let strongSelf = self else { return }
            if strongSelf.networkReachability?.isReachable ?? false {
                
                if case .reachable(_) = status {
                    // there is internet
                    strongSelf.noInternetAlert?.dismiss(animated: true, completion: { [weak self] in
                        self?.noInternetAlert = nil
                    })
                    strongSelf.noInternetHandler?()
                    strongSelf.noInternetHandler = nil
                    strongSelf.networkReachability?.stopListening()
                }
            }
        }
        networkReachability?.startListening()
    }

}

// MARK: - Base Protocol
extension BaseViewController: BaseProtocol {
    
    func handleAPIError(error: APIError) {
        showProgressHUD(false)
        switch error {
        case .noInternet:
            handleNoInternet(handler: noInternetHandler)
        case .requestCanceled:
            handleUnauthorizadError()
        case let .requestResponse(reason: reason, errorCode: errorCode):
            if errorCode == 404 {
                handleUnauthorizadError()
            } else {
                showOkAlert(title: L10n.alertTitleError, message: reason)
            }
        case let .unknown(reason: reason):
            showOkAlert(title: L10n.alertTitleError, message: reason ?? "")
        default:
            break
        }
    }
    
    func startLoading() {
        showProgressHUD(true)
    }
    
    func stopLoading() {
        showProgressHUD(false)
    }
}
