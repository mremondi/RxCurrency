//
//  ViewControllerFactory.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation

protocol ViewControllerFactory{
    func makeHomeViewController(navigator: Navigator) -> HomeViewController
}
