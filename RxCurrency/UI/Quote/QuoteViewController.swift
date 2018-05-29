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
    
    let symbol: Symbol!
    let navigator: Navigator!
    let quoteView: QuoteView!
    let interactor: QuoteInteractor!
    
    init(symbol: Symbol, navigator: Navigator, quoteView: QuoteView, interactor: QuoteInteractor) {
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
        self.quoteView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        
        interactor.getQuote(symbol: symbol).observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .next(let value):
                    print("onNext")
                    print(value)
                    self.quoteView.configureView(quote: value)
                case .error(let error):
                    print("onError: " + error.localizedDescription)
                case .completed:
                    print("completed")
                }
        }
        
        interactor.getQuoteHistory(symbol: symbol).observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .next(let value):
                    print("**********************************")
                    print("onNext quote history")
                    print(value)
                    print(value.count)
                    print("**********************************")
                    
                case .error(let error):
                    print("onError: " + error.localizedDescription)
                case .completed:
                    print("completed")
                }
        }
    }
}
