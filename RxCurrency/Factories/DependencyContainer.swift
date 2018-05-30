//
//  DependencyContainer.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation

class DependencyContainer {

}

extension DependencyContainer: ViewControllerFactory{
    func makeHomeViewController(navigator: Navigator) -> SymbolViewController {
        return SymbolViewController(navigator: navigator as! SymbolViewController.SymbolNavigation, symbolView: SymbolView(), interactor: SymbolInteractor())
    }
    
    func makeQuoteViewController(symbol: Symbol, navigator: Navigator) -> QuoteViewController{
        return QuoteViewController(symbol: symbol, navigator: navigator as! QuoteViewController.QuoteViewNavigation, quoteView: QuoteView(), interactor: QuoteInteractor())
    }
    
    func makeQuoteHistoryGraphViewController(quoteHistory: [Quote], navigator: Navigator) -> QuoteHistoryGraphViewController {
        return QuoteHistoryGraphViewController(quoteHistory: quoteHistory, navigator: navigator, quoteHistoryGraphView: QuoteHistoryGraphView(), interactor: QuoteHistoryGraphInteractor())
    }
}
