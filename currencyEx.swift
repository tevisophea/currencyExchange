//
//  currencyEx.swift
//  CurrencyExchange
//
//  Created by user on 5/12/17.
//  Copyright © 2017 Tevisophea. All rights reserved.
//

import Foundation

class currencyEx
{
    //MARK: singleton
    static let shared = currencyEx()
    
    var exchangeDict = [String: Float]()
    var rates: [Float]

    var exDict: [String: Float]
    {
        get
        {
            return self.exchangeDict
        }
        set
        {
            exchangeDict = newValue
        }
    }
    
    var exRates: [Float]
    {
        get
        {
            return self.rates
        }
        set
        {
            rates = newValue
        }
    }
    
    init(_ exRates: [Float] = [1])
    {
        self.rates = exRates
    }

    
}
