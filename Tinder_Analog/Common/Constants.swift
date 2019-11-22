//
//  Constants.swift
//  Tinder_Analog
//
//  Created by Vitaly on 07.11.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit

enum AppError: Error {
    case unknownError
    case noInternetConnection
    case incorrectDataFormat
    case incorrectLocation
    case networkError
    
    var message: String {
        switch self {
        case .unknownError:
            return "appError.unknown"
        case .noInternetConnection:
            return "appError.noInternetConnection"
        case .incorrectDataFormat:
            return "appError.incorrectDataFormat"
        case .incorrectLocation:
            return ""
        case .networkError:
            return "appError.networkError.subtitle"
        }
    }
    
    var title: String {
        switch self {
        case .networkError:
            return "appError.networkError.title"
        default:
            return "appError.errorTitle"
        }
    }
    
    var code: Int {
        switch self {
        case .incorrectDataFormat:
            return 400
        default:
            return 0
        }
    }
    
}
