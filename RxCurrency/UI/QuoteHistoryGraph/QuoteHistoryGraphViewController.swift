//
//  QuoteHistoryGraphViewController.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/30/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import UIKit
import RxSwift

class QuoteHistoryGraphViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let quoteHistory: [Quote]!
    let navigator: Navigator!
    let quoteHistoryGraphView: QuoteHistoryGraphView!
    let interactor: QuoteHistoryGraphInteractor!
    
    init(quoteHistory: [Quote], navigator: Navigator,
         quoteHistoryGraphView: QuoteHistoryGraphView, interactor: QuoteHistoryGraphInteractor) {
        self.quoteHistory = quoteHistory
        self.navigator = navigator
        self.quoteHistoryGraphView = quoteHistoryGraphView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(quoteHistoryGraphView)
        self.quoteHistoryGraphView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }
}
