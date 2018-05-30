//
//  MainNavigator.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import UIKit

class MainNavigator: Navigator{
    
    fileprivate var navigationController: UINavigationController?
    
    public var rootViewController: UIViewController {
        return navigationController!
    }
    
    typealias Factory = ViewControllerFactory
    fileprivate let factory: Factory
    
    init(factory: Factory, dismiss: @escaping () -> Void){
        self.factory = factory
        self.navigationController = UINavigationController()
        toHomeViewController()
    }
}

extension MainNavigator: HomeNavigator{
    func toHomeViewController() {
        let homeVC = factory.makeHomeViewController(navigator: self)
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

extension MainNavigator: QuoteNavigator{
    func toQuoteViewController(symbol: Symbol) {
        let quoteVC = factory.makeQuoteViewController(symbol: symbol, navigator: self)
        navigationController?.pushViewController(quoteVC, animated: true)
    }
}

extension MainNavigator: QuoteHistoryGraphNavigator{
    func toQuoteHistoryGraphViewController(quoteHistory: [Quote]) {
        let quoteHistoryGraphVC = factory.makeQuoteHistoryGraphViewController(quoteHistory: quoteHistory, navigator: self)
        navigationController?.pushViewController(quoteHistoryGraphVC, animated: true)
    }
}
