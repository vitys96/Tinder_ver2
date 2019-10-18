//
//  Loadable.swift
//  Tinder_Analog
//
//  Created by Vitaly on 16.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol Loadable {
    func startLoading()
    func stopLoading()
}

//extension Loadable where Self: UIViewController {
//    func startLoading() {
//       let hud = JGProgressHUD(style: .dark)
//       hud.textLabel.text = "Loading"
//       hud.show(in: self.view)
//    }
//
//    func stopLoading() {
//        let hud = JGProgressHUD()
//        hud.indicatorView = nil
//        if hud.isVisible {
//            hud.removeFromSuperview()
//        }
//    }
//}
