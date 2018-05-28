//
//  NetworkProvider.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//


final class NetworkProvider {
    private let apiEndpoint: String
    private let apiKey: String = "api_key=ZTFRq7X6ZI0S3R0Co0KsIkgPCRWhUPvb"
    
    public init() {
        apiEndpoint = "https://forex.1forge.com/1.0.3/"
    }
    
    public func makeSymbolsNetwork() -> SymbolsNetwork {
        let network = Network<Symbol>(apiEndpoint, apiKey: apiKey)
        return SymbolsNetwork(network: network)
    }
}
