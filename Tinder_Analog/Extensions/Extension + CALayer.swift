//
//  Extension + CALayer.swift
//  Tinder_Analog
//
//  Created by Vitaly on 09.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func setGradientBackground(aboveLayer: CALayer) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        aboveLayer.addSublayer(gradientLayer)
        gradientLayer.frame = bounds
    }
    
    func setGradient(to view: UIView) {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
