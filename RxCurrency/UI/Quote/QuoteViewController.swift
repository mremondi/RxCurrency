//
//  QuoteViewController.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/29/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import UIKit
import RxSwift

class QuoteViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    typealias QuoteViewNavigation = QuoteHistoryGraphNavigator
   
    let symbol: Symbol!
    let navigator: QuoteViewNavigation!
    let quoteView: QuoteView!
    let interactor: QuoteInteractor!
    
    var quoteHistory: [Quote]?
    
    init(symbol: Symbol, navigator: QuoteViewNavigation, quoteView: QuoteView, interactor: QuoteInteractor) {
        self.symbol = symbol
        self.navigator = navigator
        self.quoteView = quoteView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(quoteView)
        self.quoteView.delegate = self
        self.quoteView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        let quoteObservable = interactor.getQuote(symbol: symbol)
        let quoteHistoryObservable = interactor.getQuoteHistory(symbol: symbol)
        let combined = Observable.combineLatest(quoteObservable, quoteHistoryObservable)
        
        combined.subscribe { event in
            if let element = event.element{
                self.quoteView.configureView(quote: element.0)
                self.quoteHistory = element.1
                self.quoteView.configureHistory(quoteHistory: element.1)
                self.quoteView.configureTrend(trend: self.interactor.calculateLinearRegressionSlope(quoteHistory: element.1))
            }
        }.disposed(by: disposeBag)
    }
}

extension QuoteViewController: QuoteViewDelegate {
    func symbolNameTap() {
        if let quoteHistory = self.quoteHistory{
            self.navigator.toQuoteHistoryGraphViewController(quoteHistory: quoteHistory)
        }
    }
}
