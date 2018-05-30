//
//  QuoteHistoryGraphInteractor.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/30/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import RxSwift

class QuoteHistoryGraphInteractor{
    
    func isMarketOpen() -> Observable<Bool>{
        let repo = Repository()
        return repo.isMarketOpen()
    }
    
    func normalizeQuoteData(quoteHistory: [Quote]) -> [CGPoint]{
        let maxX = findMaxX(quoteHistory: quoteHistory)
        let minX = findMinX(quoteHistory: quoteHistory)
        let rangeX = maxX - minX
        let maxY = findMaxY(quoteHistory: quoteHistory)
        let minY = findMinY(quoteHistory: quoteHistory)
        let rangeY = maxY - minY
        
        var points: [CGPoint] = []
        // normalize X
        for quote in quoteHistory{
            let x = (Double(quote.timeStamp) - minX) / (rangeX)
            let y = (Double(quote.price) - minY) / (rangeY)
            points.append(CGPoint(x: x, y: y))
        }
        return points
    }
    
    
    func calculateLinearRegressionPoints(quoteHistory: [Quote]) -> [CGPoint]{
        let normalizedPoints = normalizeQuoteData(quoteHistory: quoteHistory)
        var xs: [Double] = []
        var ys: [Double] = []
        normalizedPoints.forEach {
            xs.append(Double($0.x))
            ys.append(Double($0.y))
        }
        let sum1 = average(multiply(ys, xs)) - average(xs) * average(ys)
        let sum2 = average(multiply(xs, xs)) - pow(average(xs), 2)
        let slope = sum1 / sum2
        let intercept = average(ys) - slope * average(xs)
        let point0 = CGPoint(x: 0.0, y: intercept)
        let point1 = CGPoint(x: 1.0, y: intercept + slope * 1.0)
        return [point0, point1]
    }
    
    private func findMaxX(quoteHistory: [Quote]) -> Double{
        var max = 0.0
        for quote in quoteHistory{
            if Double(quote.timeStamp) > max{
                max = Double(quote.timeStamp)
            }
        }
        return max
    }
    
    private func findMaxY(quoteHistory: [Quote]) -> Double{
        var max = 0.0
        for quote in quoteHistory{
            if quote.price > max{
                max = quote.price
            }
        }
        return max
    }
    
    private func findMinX(quoteHistory: [Quote]) -> Double{
        var min = Double.infinity
        for quote in quoteHistory{
            if Double(quote.timeStamp) < min {
                min = Double(quote.timeStamp)
            }
        }
        return min
    }
    
    private func findMinY(quoteHistory: [Quote]) -> Double{
        var min = Double.infinity
        for quote in quoteHistory{
            if quote.price < min{
                min = quote.price
            }
        }
        return min
    }
    
    private func average(_ input: [Double]) -> Double {
        return input.reduce(0, +) / Double(input.count)
    }
    
    private func multiply(_ a: [Double], _ b: [Double]) -> [Double] {
        return zip(a,b).map(*)
    }
}
