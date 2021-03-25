//
//  CurrencyRepositories.swift
//  Currex
//
//  Created by Serhan Khan on 21/01/2021.
//

import Foundation



protocol CurrenciesRepository{
    @discardableResult
    func fetchCurrencies(for base:String,completion:@escaping (Result<ExchangeRates , Error>) -> Void)->Cancellable?
}
