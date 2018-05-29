//
//  SymbolUseCase.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import RxSwift

public protocol SymbolUseCase {
    func symbols() -> Observable<[Symbol]>
}
