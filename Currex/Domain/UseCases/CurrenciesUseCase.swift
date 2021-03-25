//
//  CurrenciesUseCases.swift
//  Currex
//
//  Created by Serhan Khan on 25/01/2021.
//

import Foundation


protocol CurrenciesUseCase {
    func execute(for base:String,completion:@escaping (Result<ExchangeRates,Error>)->Void)->Cancellable?
}


class DefaultCurrenciesUseCase:CurrenciesUseCase{
    
    private let currenciesRepository:CurrenciesRepository
    
    init(currenciesRepository:CurrenciesRepository){
        self.currenciesRepository = currenciesRepository
    }
    func execute(for base:String,completion: @escaping (Result<ExchangeRates, Error>) -> Void) -> Cancellable? {
        return self.currenciesRepository.fetchCurrencies(for: base, completion: completion)
    }
    
}
