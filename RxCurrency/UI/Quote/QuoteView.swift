//
//  QuoteView.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/29/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import UIKit

class QuoteView: UIView{
    var quote: Quote?
    
    var symbolNameLabel: UILabel!
    var quotePriceLabel: UILabel!
    var quoteBidLabel: UILabel!
    var quoteAskLabel: UILabel!
    var quoteTimeLabel: UILabel!
    
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
        quotePriceLabel = UILabel()
        quoteBidLabel = UILabel()
        quoteAskLabel = UILabel()
        quoteTimeLabel = UILabel()
        
        [symbolNameLabel, quotePriceLabel, quoteBidLabel, quoteAskLabel, quoteTimeLabel].forEach{
            addSubview($0)
        }
    }
    
    func initConstraints(){
        symbolNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        symbolNameLabel.font = UIFont(name: StyleKit.Font.bold, size: 24)
        symbolNameLabel.textColor = .black
    }
    
    func configureView(quote: Quote){
        self.quote = quote
        symbolNameLabel.text = "Quote: " + quote.symbolName
        
    }
}
