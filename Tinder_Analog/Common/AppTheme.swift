//
//  AppTheme.swift
//  Tinder_Analog
//
//  Created by Vitaly on 01.11.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit

enum AppTheme: String, CaseIterable {
    case light
    
    var name: String {
        switch self {
        case .light:
            return "light"
        }
    }
}


extension UIColor {
    @nonobjc static var background: UIColor {
        return #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9803921569, alpha: 1) //F9F9FA
    }
    
    @nonobjc static var cellSeparator: UIColor {
            return #colorLiteral(red: 0.8549019608, green: 0.8509803922, blue: 0.8666666667, alpha: 1) //DAD9DD
        }
}
