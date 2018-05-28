//
//  SymbolsNetwork.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import RxSwift

public final class SymbolsNetwork {
    private let network: Network<Symbol>
    
    init(network: Network<Symbol>) {
        self.network = network
    }
    
    public func getSymbols() -> Observable<[Symbol]> {
        return network.getItems("symbols?")
    }
}
