//
//  HomeScreenProtocols.swift
//  Tinder_Analog
//
//  Created Vitaly on 08/10/2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//
//  Template generated by Sakhabaev Egor @Banck
//  https://github.com/Banck/Swift-viper-template-for-xcode
//

import Foundation

//MARK: Wireframe -
enum HomeScreenNavigationOption {
    //    case firstModule
    //    case secondModule(someData)
}

protocol HomeScreenWireframeInterface: class {
    func navigate(to option: HomeScreenNavigationOption)
}

//MARK: Presenter -
protocol HomeScreenPresenterInterface: class {

    var interactor: HomeScreenInteractorInput? { get set }
    
    // MARK: - Lifecycle -
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()

}
extension HomeScreenPresenterInterface {
    func viewDidLoad() {/*leaves this empty*/}
    func viewWillAppear() {/*leaves this empty*/}
    func viewDidAppear() {/*leaves this empty*/}
    func viewWillDisappear() {/*leaves this empty*/}
    func viewDidDisappear() {/*leaves this empty*/}
}


//MARK: Interactor -
protocol HomeScreenInteractorOutput: class {

    /* Interactor -> Presenter */
}

protocol HomeScreenInteractorInput: class {

    var presenter: HomeScreenInteractorOutput?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol HomeScreenView: class {

    var presenter: HomeScreenPresenterInterface?  { get set }
    func displayData(_ data: [CardView.Data])

    /* Presenter -> ViewController */
}
