//
//  Repository.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/28/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import CoreData

class Repository {
    
    func isMarketOpen() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            Alamofire.request("https://forex.1forge.com/1.0.3/market_status?api_key=ZTFRq7X6ZI0S3R0Co0KsIkgPCRWhUPvb").responseJSON(completionHandler: {response in
                if let response = response.result.value{
                    let dict = response as! NSDictionary
                    let isOpen = dict["market_is_open"] as! Bool
                    observer.onNext(isOpen)
                }
            })
            return Disposables.create()
        }
    }
    
    func getSymbols() -> Observable<[Symbol]>{
        return Observable<[Symbol]>.create { observer in
            Alamofire.request("https://forex.1forge.com/1.0.3/symbols?api_key=ZTFRq7X6ZI0S3R0Co0KsIkgPCRWhUPvb")
                .responseJSON(completionHandler: { response in
                    if let response = response.result.value{
                        let JSON = response as! NSArray
                        var symbols: [Symbol] = []
                        JSON.forEach{
                            symbols.append(Symbol(symbolName: $0 as! String))
                        }
                        observer.onNext(symbols)
                    }
            })
            return Disposables.create()
        }
    }
    
    func getQuote(symbol: Symbol) -> Observable<Quote>{
        return Observable<Quote>.create { observer in
            let baseURL = "https://forex.1forge.com/1.0.3/quotes?pairs="
            let apiKey = "&api_key=ZTFRq7X6ZI0S3R0Co0KsIkgPCRWhUPvb"
            let url = baseURL + symbol.symbolName + apiKey
            Alamofire.request(url).responseJSON(completionHandler: { response in
                if let response = response.result.value{
                    let JSON = response as! NSArray
                    let dict = JSON[0] as! NSDictionary
                    let symbolName = dict["symbol"] as! String
                    let timestamp = dict["timestamp"] as! Int
                    let price = dict["price"] as! Double
                    let bid = dict["bid"] as! Double
                    let ask = dict["ask"] as! Double
                    let quote = Quote(symbolName: symbolName, bid: bid, ask: ask, price: price, timeStamp: timestamp)
                    
                    self.saveQuoteToCache(quote: quote)
                    
                    
                    observer.onNext(quote)
                }
            })
            return Disposables.create()
        }
    }
    
    func getQuoteHistory(symbol: Symbol) -> Observable<[Quote]> {
        return Observable<[Quote]>.create { observer in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "QuoteCache")
            
            do {
                let managedQuotes = try managedContext.fetch(fetchRequest)
            
                let quotes = self.mapManagedQuotes(managedQuotes: managedQuotes, symbol: symbol)
                observer.onNext(quotes)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            return Disposables.create()
        }
    }
    
    private func mapManagedQuotes(managedQuotes: [NSManagedObject], symbol: Symbol) -> [Quote]{
        var quotes: [Quote] = []
        managedQuotes.forEach {
            let managedQuote = $0
            let quote = Quote(symbolName: managedQuote.value(forKey: "symbolName") as! String,
                              bid: managedQuote.value(forKey: "bid") as! Double,
                              ask: managedQuote.value(forKey: "ask") as! Double,
                              price: managedQuote.value(forKey: "price") as! Double,
                              timeStamp: managedQuote.value(forKey: "timestamp") as! Int)
            if quote.symbolName == symbol.symbolName{
                quotes.append(quote)
            }
        }
        return quotes
    }
    
    private func saveQuoteToCache(quote: Quote){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "QuoteCache", in: managedContext)!
        
        let quoteCache = NSManagedObject(entity: entity, insertInto: managedContext)
        
        quoteCache.setValue(quote.symbolName, forKeyPath: "symbolName")
        quoteCache.setValue(quote.ask, forKeyPath: "ask")
        quoteCache.setValue(quote.bid, forKeyPath: "bid")
        quoteCache.setValue(quote.price, forKeyPath: "price")
        quoteCache.setValue(quote.timeStamp, forKeyPath: "timestamp")

        do {
            try managedContext.save()
            //people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
