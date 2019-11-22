//
//  SettingsPresenter.swift
//  Tinder_Analog
//
//  Created by Vitaly on 02.11.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit

class SettingsPresenter {
    // MARK: - Properties
    weak private var view: SettingsView?
    var interactor: SettingsInteractorInput?
    private let router: SettingsWireframeInterface
    
    // MARK: - Initialization and deinitialization -
    init(interface: SettingsView, interactor: SettingsInteractorInput?, router: SettingsWireframeInterface) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - SettingsPresenterInterface -
extension SettingsPresenter: SettingsPresenterInterface {
    
    // MARK: - Lifecycle
    func viewWillAppear() {
        fetchCurrentUserData()
    }
    
    func didSelectFotoPicker(button: UIButton) {
        self.view?.showCameraManager(button: button, completion: nil)
    }
}

// MARK: - SettingsInteractorOutput -
extension SettingsPresenter: SettingsInteractorOutput {
    func fetchedUsersPhotos(userPhotos: [UIImage]?) {
        let buttonFont = UIFont.boldSystemFont(ofSize: 20)
        let topViewData = SettingTopCell.Data(images: userPhotos!, buttonFont: buttonFont)
        view?.displayTopViewRows(data: [topViewData])
        self.view?.stopLoading()
    }
    
    func fetchedUserData(userData: User?) {
        if let usersPhotoUrls = userData?.imageUrl {
            interactor?.fetchUserPhotos(imageUrls: usersPhotoUrls)
        }
        
        var mainRowsSections: [(rowData: TextFieldCell.Data, sectionTitle: String)] = []
        //Name
        let nameRow = TextFieldCell.Data(textFieldPlaceholder: "Enter Name", textFieldText: userData?.name)
        mainRowsSections.append((rowData: nameRow, sectionTitle: "Name"))
        
        //Profession
        let professionRow = TextFieldCell.Data(textFieldPlaceholder: "Enter Profession", textFieldText: userData?.profession)
        mainRowsSections.append((rowData: professionRow, sectionTitle: "Profession"))
        
        //Age
        let ageRow = TextFieldCell.Data(textFieldPlaceholder: "Enter Age", keybordType: .numberPad, textFieldText: userData?.age)
        mainRowsSections.append((rowData: ageRow, sectionTitle: "Age"))
        
        
        //Bio
        let bioRow = TextFieldCell.Data(textFieldPlaceholder: "Enter Bio", textFieldText: userData?.name)
        mainRowsSections.append((rowData: bioRow, sectionTitle: "Bio"))
        
        view?.displayMainRows(sectionsData: mainRowsSections)
    }
    
    func fetchedUserData(with error: Error) {
        view?.showClosedErrorAlert(labelText: "Ошибка", detailText: error.localizedDescription, closedAction: {
            self.router.navigate(to: .mainScreen)
        })
    }
    
    func fetchedUsersPhotos(with error: Error) {
        view?.showClosedErrorAlert(labelText: "Ошибка", detailText: error.localizedDescription, closedAction: {
            self.router.navigate(to: .mainScreen)
        })
    }
}

extension SettingsPresenter {
    
    private func fetchCurrentUserData() {
        interactor?.fetchUserData()
        self.view?.startLoading()
    }
}
