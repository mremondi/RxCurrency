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
    var quoteHistory: [Quote] = []
    var trendLine: ((Double) -> Double)?
    
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
        
        [].forEach{
            addSubview($0)
        }
    }
    
    func initConstraints(){

    }
    
    func configureView(){
    
    }
}
