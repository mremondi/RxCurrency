//
//  File.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import UIKit

fileprivate let symbolTableReuseIdentifier = "SymbolTableCell"

protocol SymbolViewDelegate{
    func symbolChosen(symbol: Symbol)
}

class SymbolView: UIView{
    var symbols: [Symbol] = []
    var delegate: SymbolViewDelegate?
    
    var symbolTableView: UITableView!
    
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
        // may not need this with navbar
        symbolTableView = UITableView(frame: .zero)
        symbolTableView.dataSource = self
        symbolTableView.delegate = self
        symbolTableView.register(SymbolTableCell.self, forCellReuseIdentifier: symbolTableReuseIdentifier)
        symbolTableView.rowHeight = 44.0

        
        [symbolTableView].forEach{
            addSubview($0)
        }
    }
    
    func initConstraints(){
        symbolTableView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    func configureView(symbols: [Symbol], delegate: SymbolViewDelegate){
        self.symbols = symbols
        self.delegate = delegate
        self.symbolTableView.reloadData()
    }
}

extension SymbolView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: symbolTableReuseIdentifier) as! SymbolTableCell
        cell.configure(symbolName: self.symbols[indexPath.row].symbolName)
        cell.isUserInteractionEnabled = true
        return cell
    }
}

extension SymbolView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.symbolChosen(symbol: self.symbols[indexPath.row])
    }
}
