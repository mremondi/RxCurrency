//
//  SymbolViewModel.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation

final class SymbolViewModel{
    let symbolName: String
    let symbol: Symbol
    init(with symbol: Symbol) {
        self.symbol = symbol
        self.symbolName = symbol.symbolName
    }
}
