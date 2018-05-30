//
//  QuoteView.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/29/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import UIKit

fileprivate let quoteHistoryCellReuseIdentifier = "QuoteHistoryCell"

protocol QuoteViewDelegate {
    func symbolNameTap()
}

class QuoteView: UIView{
    
    var delegate: QuoteViewDelegate?
    
    var quote: Quote?
    var quoteHistory: [Quote] = []
    
    var symbolNameLabel: UILabel!
    var dividerOne: UIView!
    var currentLabel: UILabel!
    var priceLabel: UILabel!
    var bidLabel: UILabel!
    var askLabel: UILabel!
    var quotePriceLabel: UILabel!
    var quoteBidLabel: UILabel!
    var quoteAskLabel: UILabel!
    var quoteTimeLabel: UILabel!
    var dividerTwo: UIView!
    var quoteHistoryTableView: UITableView!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        initViews()
        initConstraints()
    }
    
    func initViews(){
        symbolNameLabel = UILabel()
        dividerOne = UIView()
        currentLabel = UILabel()
        priceLabel = UILabel()
        bidLabel = UILabel()
        askLabel = UILabel()
        quotePriceLabel = UILabel()
        quoteBidLabel = UILabel()
        quoteAskLabel = UILabel()
        quoteTimeLabel = UILabel()
        dividerTwo = UIView()
        quoteHistoryTableView = UITableView(frame: .zero)
        quoteHistoryTableView.delegate = self
        quoteHistoryTableView.dataSource = self
        quoteHistoryTableView.register(QuoteHistoryCell.self, forCellReuseIdentifier: quoteHistoryCellReuseIdentifier)
        quoteHistoryTableView.rowHeight = 44.0

        
        [symbolNameLabel, dividerOne, currentLabel, quotePriceLabel, quoteBidLabel, quoteAskLabel, priceLabel, bidLabel, askLabel, quoteTimeLabel, dividerTwo, quoteHistoryTableView].forEach{
            addSubview($0)
        }
    }
    
    func initConstraints(){
        symbolNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        symbolNameLabel.font = UIFont(name: StyleKit.Font.bold, size: 32)
        symbolNameLabel.textColor = .black
        symbolNameLabel.isUserInteractionEnabled = true
        symbolNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(QuoteView.symbolNameTap)))
        
        dividerOne.anchor(top: symbolNameLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        dividerOne.backgroundColor = .lightGray
        
        currentLabel.anchor(top: dividerOne.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        currentLabel.font = UIFont(name: StyleKit.Font.bold, size: 28)
        currentLabel.textColor = .black
        currentLabel.text = "Current"
        
        priceLabel.anchorCenterX(to: self)
        priceLabel.anchor(top: currentLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        priceLabel.font = UIFont(name: StyleKit.Font.bold, size: 22)
        priceLabel.textColor = .black
        priceLabel.text = "Price"
        
        bidLabel.anchor(top: currentLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        bidLabel.font = UIFont(name: StyleKit.Font.bold, size: 18)
        bidLabel.textColor = .black
        bidLabel.text = "Bid"
        
        askLabel.anchor(top: currentLabel.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16))
        askLabel.font = UIFont(name: StyleKit.Font.bold, size: 18)
        askLabel.textColor = .black
        askLabel.text = "Ask"
        
        quotePriceLabel.anchorCenterX(to: self)
        quotePriceLabel.anchor(top: priceLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        quotePriceLabel.font = UIFont(name: StyleKit.Font.bold, size: 22)
        quotePriceLabel.textColor = .black
        
        quoteBidLabel.anchor(top: bidLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        quoteBidLabel.font = UIFont(name: StyleKit.Font.regular, size: 18)
        quoteBidLabel.textColor = .black
        
        quoteAskLabel.anchor(top: askLabel.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16))
        quoteAskLabel.font = UIFont(name: StyleKit.Font.regular, size: 18)
        quoteAskLabel.textColor = .black
        
        dividerTwo.anchor(top: quotePriceLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        dividerTwo.backgroundColor = .lightGray
        
        quoteHistoryTableView.anchor(top: dividerTwo.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    func configureView(quote: Quote){
        self.quote = quote
        symbolNameLabel.text = "Quote: " + quote.symbolName
        quotePriceLabel.text = "$" + String(format: "%.6f", quote.price)
        quoteAskLabel.text = "$" + String(format: "%.6f", quote.ask)
        quoteBidLabel.text = "$" + String(format: "%.6f", quote.bid)
    }
    
    func configureHistory(quoteHistory: [Quote]){
        self.quoteHistory = quoteHistory
        self.quoteHistoryTableView.reloadData()
    }
    
    func configureTrend(trend: Double){
        if let symbolName = quote?.symbolName {
            if trend > 0{
                self.symbolNameLabel.text = symbolName + "📈"
            } else {
                self.symbolNameLabel.text = symbolName + "📉"
            }
        }
    }
    
    @objc func symbolNameTap(){
        delegate?.symbolNameTap()
    }
}

extension QuoteView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quoteHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: quoteHistoryCellReuseIdentifier) as! QuoteHistoryCell
        cell.configure(quote: self.quoteHistory[indexPath.row])
        return cell
    }
}

extension QuoteView: UITableViewDelegate{}
