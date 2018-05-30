//
//  QuoteHistoryCell.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/30/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import UIKit

class QuoteHistoryCell: UITableViewCell{
    var quotePriceLabel: UILabel!
    var quoteBidLabel: UILabel!
    var quoteAskLabel: UILabel!
    var quoteTimeLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        initConstraints()
    }
    
    func initViews(){
        quotePriceLabel = UILabel()
        quoteBidLabel = UILabel()
        quoteAskLabel = UILabel()
        quoteTimeLabel = UILabel()
        [quotePriceLabel, quoteBidLabel, quoteAskLabel, quoteTimeLabel].forEach { contentView.addSubview($0) }
    }
    
    func initConstraints(){
        
        quoteBidLabel.anchorCenterY(to: contentView)
        quoteBidLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        quoteBidLabel.font = UIFont(name: StyleKit.Font.regular, size: 12)
        
        quotePriceLabel.anchorCenterY(to: contentView)
        quotePriceLabel.anchor(top: nil, leading: quoteBidLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 60, bottom: 0, right: 0))
        quotePriceLabel.font = UIFont(name: StyleKit.Font.bold, size: 12)
        
        quoteAskLabel.anchorCenterY(to: contentView)
        quoteAskLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: quoteTimeLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 60))
        quoteAskLabel.font = UIFont(name: StyleKit.Font.regular, size: 12)
        
        quoteTimeLabel.anchorCenterY(to: contentView)
        quoteTimeLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        quoteTimeLabel.font = UIFont(name: StyleKit.Font.regular, size: 12)
    }
    
    func configure(quote: Quote) {
        quoteBidLabel.text = String(format: "%.6f", quote.bid)
        quotePriceLabel.text = String(format: "%.6f", quote.price)
        quoteAskLabel.text = String(format: "%.6f", quote.ask)
        quoteTimeLabel.text = String(quote.timeStamp)
    }
}
