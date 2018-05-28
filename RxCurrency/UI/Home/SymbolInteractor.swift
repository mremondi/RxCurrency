//
//  HomeInteractor.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import RxSwift

class SymbolInteractor{
    func getSymbols(){
        let repo = Repository()
        repo.getSymbols().observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .next(let value):
                    print("onNext")
                    print(value)
                    //self.homeView.configureView(symbols: value)
                case .error(let error):
                    print("onError")
                case .completed:
                    print("completed")
                }
        }
    }
}
