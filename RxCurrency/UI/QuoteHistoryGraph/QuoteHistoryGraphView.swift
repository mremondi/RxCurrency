//
//  QuoteHistoryGraphView.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/30/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import UIKit

class QuoteHistoryGraphView: UIView{
    var symbolNameLabel: UILabel!
    var graphView: GraphView!
    var xAxisLabel1: UILabel!
    var xAxisLabel2: UILabel!
    var yAxisLabel1: UILabel!
    var yAxisLabel2: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(quotePoints: [CGPoint], trendLine: [CGPoint]) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        graphView = GraphView(points: quotePoints, trendLine: trendLine)
        initViews()
        initConstraints()
    }
    
    func initViews(){
        symbolNameLabel = UILabel()
        xAxisLabel1 = UILabel()
        xAxisLabel2 = UILabel()
        yAxisLabel1 = UILabel()
        yAxisLabel2 = UILabel()
        [symbolNameLabel, graphView, xAxisLabel1, xAxisLabel2, yAxisLabel1, yAxisLabel2].forEach{
            addSubview($0)
        }
    }
    
    func initConstraints(){
        symbolNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        symbolNameLabel.font = UIFont(name: StyleKit.Font.bold, size: 32)
        symbolNameLabel.textColor = .black
        
        graphView.anchor(top: symbolNameLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 300))
        
        xAxisLabel1.anchor(top: graphView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 24, bottom: 0, right: 0))
        xAxisLabel1.font = UIFont(name: StyleKit.Font.thin, size: 12)
        xAxisLabel1.textColor = .black
        
        xAxisLabel2.anchor(top: graphView.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 8))
        xAxisLabel2.font = UIFont(name: StyleKit.Font.thin, size: 12)
        xAxisLabel2.textColor = .black
        
        yAxisLabel1.anchor(top: graphView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: -16, left: 24, bottom: 0, right: 0))
        yAxisLabel1.font = UIFont(name: StyleKit.Font.thin, size: 12)
        yAxisLabel1.textColor = .black
        
        yAxisLabel2.anchor(top: graphView.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 0))
        yAxisLabel2.font = UIFont(name: StyleKit.Font.thin, size: 12)
        yAxisLabel2.textColor = .black
    }
    
    func configureBackground(isOpen: Bool){
        if isOpen{
            self.backgroundColor = StyleKit.Colors.marketOpenBackground
        }
        else {
            self.backgroundColor = StyleKit.Colors.marketClosedBackground
        }
    }
    
    func configureView(quoteHistory: [Quote]){
        symbolNameLabel.text = quoteHistory[0].symbolName
        xAxisLabel1.text = String(findMinX(quoteHistory: quoteHistory))
        xAxisLabel2.text = String(findMaxX(quoteHistory: quoteHistory))
        yAxisLabel1.text = String(findMinY(quoteHistory: quoteHistory))
        yAxisLabel2.text = String(findMaxY(quoteHistory: quoteHistory))
    }
    
    private func findMinX(quoteHistory: [Quote]) -> Int{
        var min = Int.max
        for quote in quoteHistory{
            if quote.timeStamp < min{
                min = quote.timeStamp
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
    
    private func findMaxX(quoteHistory: [Quote]) -> Int{
        var max = -1
        for quote in quoteHistory{
            if quote.timeStamp > max{
                max = quote.timeStamp
            }
        }
        return max
    }
    
    private func findMaxY(quoteHistory: [Quote]) -> Double{
        var max = -1.0
        for quote in quoteHistory{
            if quote.price > max{
                max = quote.price
            }
        }
        return max
    }
}
