//
//  AlertManager.swift
//  Tinder_Analog
//
//  Created by Vitaly on 15.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import JGProgressHUD

struct AlertManager {
    private static var hud: JGProgressHUD?
//    private static var currentAlert: UIView?
    static func closeCurrentAlert(completion: (()->())? = nil) {
        
    }
    
    static func showErrorAlert(labelText: String? = nil, detailText: String?, on view: UIView) {
        let errorAlert = JGProgressHUD(style: .dark)
        errorAlert.indicatorView = JGProgressHUDErrorIndicatorView()
        errorAlert.textLabel.text = labelText
        errorAlert.detailTextLabel.text = detailText
        errorAlert.show(in: view)
        errorAlert.tapOutsideBlock = { (hud) in
            hud.dismiss()
        }
    }
    
    static func showSuccessAlert(labelText: String? = nil, detailText: String?, on view: UIView) {
        let errorAlert = JGProgressHUD(style: .dark)
        errorAlert.indicatorView = JGProgressHUDSuccessIndicatorView()
        errorAlert.textLabel.text = labelText
        errorAlert.detailTextLabel.text = detailText
        errorAlert.show(in: view)
        errorAlert.tapOutsideBlock = { (hud) in
            hud.dismiss()
        }
    }
    
}
