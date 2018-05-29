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
        return SymbolViewController(navigator: navigator as! SymbolViewController.SymbolNavigation, symbolView: SymbolView(), interactor: SymbolInteractor())
    }
    
    func makeQuoteViewController(symbol: Symbol, navigator: Navigator) -> QuoteViewController{
        return QuoteViewController(symbol: symbol, navigator: navigator, quoteView: QuoteView(), interactor: QuoteInteractor())
    }
}
