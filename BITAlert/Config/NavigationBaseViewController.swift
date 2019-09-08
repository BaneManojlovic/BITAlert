//
//  NavigationBaseViewController.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import UIKit

class NavigationBaseViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        self.hidesBottomBarWhenPushed = true
    }
    
    // MARK: - Methods
    
    func setBackButton() {
        let customBackButton = UIBarButtonItem(
            image: Asset.arrowBackIcon.image,
            style: .plain,
            target: self,
            action: #selector(backAction))
     //   customBackButton.tintColor = ColorName.purpleColor.color
        customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    // MARK: - Action methods
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
