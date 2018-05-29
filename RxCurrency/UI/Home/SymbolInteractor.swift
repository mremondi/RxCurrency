//
//  HomeInteractor.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import RxSwift

class SymbolInteractor{
    func getSymbols() -> Observable<[Symbol]>{
        let repo = Repository()
        return repo.getSymbols()
    }
}
