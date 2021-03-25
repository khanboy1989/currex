//
//  DefaultCurrencyRepository.swift
//  Currex
//
//  Created by Serhan Khan on 21/01/2021.
//

import Foundation



final class DefaultCurrenciesRepository{
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService:DataTransferService){
        self.dataTransferService = dataTransferService
    }
}

extension DefaultCurrenciesRepository:CurrenciesRepository{
    func fetchCurrencies(for base:String,completion: @escaping (Result<ExchangeRates, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getExchangeRates(for: base)
        task.networkTask = dataTransferService.request(with: endpoint, completion:{
            result in
            switch result {
            case .success(let exchangeRates):
                completion(.success(exchangeRates))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return task
    }
}
