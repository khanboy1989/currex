//
//  CurrencyListViewModel.swift
//  Currex
//
//  Created by Serhan Khan on 15/01/2021.
//

import Foundation
import Combine

struct CurrencyListViewModelActios {
    let pop:()->Void
}

protocol CurrencyListInputViewModel{
    func pop()
    func exchangeRates(for base:CurrencyListItemViewModel)
    func initialExchangeRates()
    func convert(amount:String?)
}

protocol CurrencyListOutputViewModel{
    var screenTitle:String {get}
    var currencyScreenState:PassthroughSubject<ScreenState<([CurrencyListItemViewModel],CurrencyListItemViewModel)>,Never>{get}
}

protocol CurrencyListViewModel:CurrencyListInputViewModel, CurrencyListOutputViewModel {}


final class DefaultCurrencyListViewModel:CurrencyListViewModel{
    var currencyScreenState: PassthroughSubject<ScreenState<([CurrencyListItemViewModel],CurrencyListItemViewModel)>, Never> = PassthroughSubject<ScreenState<([CurrencyListItemViewModel],CurrencyListItemViewModel)>,Never>()
    
    var toCurrencyItemSubject: PassthroughSubject<CurrencyListItemViewModel?, Never> = PassthroughSubject<CurrencyListItemViewModel?,Never>()
    
    var convertedAmountSubject:PassthroughSubject<(String?,ConversionDirection),Never> = PassthroughSubject<(String?,ConversionDirection),Never>()
    
    private let actions:CurrencyListViewModelActios?
    private let useCase:CurrenciesUseCase
    private var baseCurrency:String
    
    // CurrencyListItemViewModel
    private var currencyListItemViewModels:[CurrencyListItemViewModel]?
    
    private var currenciesLoadTask: Cancellable?{
        willSet {
            currenciesLoadTask?.cancel()
        }
    }
    
    init(useCase:CurrenciesUseCase,actions:CurrencyListViewModelActios? = nil,baseCurrency:String){
        self.actions = actions
        self.useCase = useCase
        self.baseCurrency = baseCurrency
    }
    
    private func getCurrencies(for base:String){
        currencyScreenState.send(.loading)
        currenciesLoadTask = self.useCase.execute(for: base, completion: {[weak self]
            result in
            self?.currencyScreenState.send(.finished)
            switch result{
            case .failure(let error):
                self?.currencyScreenState.send(.error(error: error.localizedDescription))
            case .success(let data):
                self?.sendSnapShot(data: data)
            }
        })
    }
    
    private func sendSnapShot(data:ExchangeRates){
        let currencies = data.rates.map({CurrencyListItemViewModel(sellRate: $0.value, currencyCode: $0.key)}).sorted{$0.currencyCode < $1.currencyCode}
        self.currencyListItemViewModels = currencies
        
        guard data.base != Constants.baseEURCurrency else {
            let baseEURCurrencyListItemViewModel = CurrencyListItemViewModel(sellRate: 1.0, currencyCode: Constants.baseEURCurrency, calculatedAmount: nil)
            
            self.currencyListItemViewModels?.append(baseEURCurrencyListItemViewModel)
            
            guard let newCurrencies = self.currencyListItemViewModels else {return}
            
            let sorted = newCurrencies.sorted{$0.currencyCode < $1.currencyCode}
            
            self.currencyScreenState.send(.succes(data:( sorted,baseEURCurrencyListItemViewModel)))
            return}
        
        guard let baseCurrenctListViewItem = currencies.first(where: {$0.currencyCode == self.baseCurrency}) else {return}
        self.currencyScreenState.send(.succes(data:( currencies,baseCurrenctListViewItem)))
    }
    
    private func calculate(amount:String?){
        let convertedValues = self.currencyListItemViewModels?.compactMap({ (currencyListItemViewModel) -> CurrencyListItemViewModel in
            
            var mutableItem = currencyListItemViewModel
            
            if let amount = amount?.toDouble {
                mutableItem.changeAmount(calculatedAmount: (String(format: "%.2f", amount * currencyListItemViewModel.sellRate)))
                return mutableItem
            }else {
                mutableItem.changeAmount(calculatedAmount: nil)
                return mutableItem
            }
        })
        guard let baseCurrenctListViewItem = currencyListItemViewModels?.first(where: {$0.currencyCode == self.baseCurrency}), let converted = convertedValues else {return}
        self.currencyScreenState.send(.succes(data:( converted,baseCurrenctListViewItem)))
    }
}

//MARK: - DefaultCurrencyListViewModel
//Used as en extension to apply the implementation of CurrencyListViewModel (For Input and Output)
extension DefaultCurrencyListViewModel{
    var screenTitle:String{
        return L10n.exchangeRates
    }
    
    func pop(){
        actions?.pop()
    }
    
    func exchangeRates(for base:CurrencyListItemViewModel) {
        self.baseCurrency = base.currencyCode
        getCurrencies(for: self.baseCurrency)
    }
    
    func initialExchangeRates() {
        getCurrencies(for: baseCurrency)
    }
    
    func convert(amount:String?){
        self.calculate(amount: amount)
    }
    
}
