//
//  SymbolTableCell.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import UIKit

class SymbolTableCell: UITableViewCell{
    var symbolLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        initConstraints()
        
    }
    
    func initViews(){
        symbolLabel = UILabel()
        [symbolLabel].forEach { contentView.addSubview($0) }
    }
    
    func initConstraints(){
        symbolLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,
                             padding: .init(top: 0, left: 32.0, bottom: 0, right: 0),
                             size: .init(width: 150, height: 0))
        symbolLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    func configure(symbolName: String) {
        symbolLabel.text = symbolName
    }
}
