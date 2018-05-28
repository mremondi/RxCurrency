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
    
    let symbolView: SymbolView!
    let interactor: SymbolInteractor!
    
    init(symbolView: SymbolView, interactor: SymbolInteractor) {
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
        
        
        
    }
}
