//
//  ViewInterface.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/9/20.
//  Copyright © 2020 CanhTran. All rights reserved.

import UIKit

protocol ViewInterface: AnyObject {
    func toController() -> UIViewController
    func showProgressHUD()
    func hideProgressHUD()
}

extension UIViewController: ViewInterface {
    func toController() -> UIViewController {
        return self
    }
}

extension ViewInterface {
    func showProgressHUD() {
        Logger.shared.info(object: "Need to show loading HUD here")
    }

    func hideProgressHUD() {
        Logger.shared.info(object: "Need to hide loading HUD here")
    }
}
