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
    
    func calculateLinearRegressionSlope(quoteHistory: [Quote]) -> Double{
        var xs: [Double] = []
        var ys: [Double] = []
        quoteHistory.forEach {
            xs.append(Double($0.timeStamp))
            ys.append($0.price)
        }
        let sum1 = average(multiply(ys, xs)) - average(xs) * average(ys)
        let sum2 = average(multiply(xs, xs)) - pow(average(xs), 2)
        let slope = sum1 / sum2
        let intercept = average(ys) - slope * average(xs)
        return slope
    }
    
    private func average(_ input: [Double]) -> Double {
        return input.reduce(0, +) / Double(input.count)
    }
    
    private func multiply(_ a: [Double], _ b: [Double]) -> [Double] {
        return zip(a,b).map(*)
    }
}
