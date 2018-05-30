//
//  ViewController.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import UIKit
import RxSwift

class SymbolViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    typealias SymbolNavigation = QuoteNavigator
    let navigator: SymbolNavigation!
    let symbolView: SymbolView!
    let interactor: SymbolInteractor!
    
    init(navigator: SymbolNavigation, symbolView: SymbolView, interactor: SymbolInteractor) {
        self.navigator = navigator
        self.symbolView = symbolView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(symbolView)
        self.symbolView.fillSuperview()
        
        
        interactor.getSymbols().observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .next(let value):
                    self.symbolView.configureView(symbols: value, delegate: self)
                case .error(let error):
                    print("onError: " + error.localizedDescription)
                case .completed:
                    print("completed")
                }
        }
    }
}

extension SymbolViewController: SymbolViewDelegate {
    func symbolChosen(symbol: Symbol) {
        navigator.toQuoteViewController(symbol: symbol)
    }
}
