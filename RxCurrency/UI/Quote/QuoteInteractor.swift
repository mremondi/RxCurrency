//
//  QuoteInteractor.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/29/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import RxSwift

class QuoteInteractor{
    func getQuote(symbol: Symbol) -> Observable<Quote>{
        let repo = Repository()
        return repo.getQuote(symbol: symbol)
    }
    
    func getQuoteHistory(symbol: Symbol) -> Observable<[Quote]>{
        let repo = Repository()
        return repo.getQuoteHistory(symbol: symbol)
    }
}
