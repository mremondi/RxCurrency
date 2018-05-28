//
//  DependencyContainer.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation

class DependencyContainer {
    //private lazy var userManager = UserManager()
}

extension DependencyContainer: ViewControllerFactory{
    func makeHomeViewController(navigator: Navigator) -> SymbolViewController {
        return SymbolViewController(symbolView: SymbolView(), interactor: SymbolInteractor())
    }
}
