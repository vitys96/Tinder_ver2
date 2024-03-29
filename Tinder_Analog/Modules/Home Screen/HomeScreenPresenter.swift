//
//  HomeScreenPresenter.swift
//  Tinder_Analog
//
//  Created Vitaly on 08/10/2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//
//  Template generated by Sakhabaev Egor @Banck
//  https://github.com/Banck/Swift-viper-template-for-xcode
//

import UIKit

class HomeScreenPresenter {
    // MARK: - Properties
    weak private var view: HomeScreenView?
    var interactor: HomeScreenInteractorInput?
    private let router: HomeScreenWireframeInterface

    // MARK: - Initialization and deinitialization -
    init(interface: HomeScreenView, interactor: HomeScreenInteractorInput?, router: HomeScreenWireframeInterface) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - HomeScreenPresenterInterface -
extension HomeScreenPresenter: HomeScreenPresenterInterface {
    func settingsDidSelect() {
        self.router.navigate(to: .settingsVC)
    }
    
    func fetchUsersFirebase() {
        self.view?.startLoading()
        self.interactor?.fetchDataFirebase()
    }
}

// MARK: - HomeScreenInteractorOutput -
extension HomeScreenPresenter: HomeScreenInteractorOutput {
    func fetchedData(data: [User]) {
        self.view?.stopLoading()
        let dataArray = data.map { CardView.Data(
            name: $0.name,
            age: $0.age,
            profession: $0.profession,
            imageNames: $0.imageUrl)
        }
        view?.displayData(dataArray)
    }
}

// MARK: - Private methods
extension HomeScreenPresenter {
    
}

