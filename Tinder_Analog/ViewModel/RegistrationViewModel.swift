//
//  RegistrationView.swift
//  Tinder_Analog
//
//  Created by Vitaly on 13.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit

struct RegistrationViewModel {
    
    var fullName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    var image: UIImage? { didSet { checkFormValidity() } }
    var isFormValidObserver: ((Bool) -> ())? = nil
    
    fileprivate func checkFormValidity() {
        let isFormValid =
            fullName?.isEmpty == false &&
            email?.isEmpty == false &&
            password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
}
