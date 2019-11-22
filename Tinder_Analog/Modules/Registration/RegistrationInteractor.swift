//
//  RegistrationInteractor.swift
//  Tinder_Analog
//
//  Created Vitaly on 12.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//
//  Template generated by Sakhabaev Egor @Banck
//  https://github.com/Banck/Swift-viper-template-for-xcode
//

import UIKit

class RegistrationInteractor: RegistrationInteractorInput {
    
    
    // MARK: - Properties
    weak var presenter: RegistrationInteractorOutput?
    
    // MARK: - RegistrationInteractorInput -
    
}
extension RegistrationInteractor {
    func createUser(userModel: RegistrationViewModel) {
        RegistrationManager.uploadData(data: userModel)
            .done { [weak self] (_) in
                self?.presenter?.fetchedRegistration()
        }
        .catch { [weak self] (error) in
            self?.presenter?.failureRegistration(with: error.localizedDescription)
        }
        .finally { }
    }
}

