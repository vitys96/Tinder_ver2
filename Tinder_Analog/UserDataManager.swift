//
//  UserDataManager.swift
//  Tinder_Analog
//
//  Created by Vitaly on 07.11.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit
import PromiseKit

struct UserDataManager {
    
    static func fetchUserData() -> Promise<User?> {
        return Promise { (resolver) in
            NetworkHelper.fetchUserData { (userData) in
                switch userData {
                case .some(let user):
                    resolver.fulfill(user)
                case .none:
                    resolver.reject(AppError.networkError)
                    return
                }
            }
        }
    }
    
    static func fetchUserPhotos(imageUrls: [String]) -> Promise<[UIImage]> {
        return Promise { (resolver) in
            NetworkHelper.fetchUserPhotos(imageUrls: imageUrls) { (images) in
                switch images {
                    case .some(let images):
                        resolver.fulfill(images)
                    case .none:
                        resolver.reject(AppError.networkError)
                        return
                }
            }
        }
    }
}
