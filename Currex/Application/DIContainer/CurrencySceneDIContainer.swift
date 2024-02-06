//
//  CurrencyListDIContainer.swift
//  Currex
//
//  Created by Serhan Khan on 15/01/2021.
//

import Foundation


final class CurrencySceneDIContainer{
    
    //MARK: - Dependecies
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    private let baseCurrency:String = Constants.baseEURCurrency.lowercased()
    
    //MARK: - Initialization
    init(dependecies:Dependencies){
        self.dependencies = dependecies
    }
    
    //MARK: - UseCases
    func makeCurrenciesUseCase()->CurrenciesUseCase {
        return DefaultCurrenciesUseCase(currenciesRepository: makeCurrenciesRepository())
    }
    
    //MARK: - Repositories
    func makeCurrenciesRepository()->CurrenciesRepository{
        return DefaultCurrenciesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    
    //MARK: - Currency List
    func makeCurrencyListViewController(actions: CurrencyListViewModelActios) -> CurrencyListViewController {
        return CurrencyListViewController(viewModel: makeCurrencyListViewModel(actions: actions))
    }
    
    //MARK: - ViewModels
    func makeCurrencyListViewModel(actions:CurrencyListViewModelActios)->CurrencyListViewModel{
        return DefaultCurrencyListViewModel(useCase: makeCurrenciesUseCase(), actions: actions, baseCurrency: baseCurrency)
    }
    
    //MARK: - Flow Coordinators
    func makeCurrencyListFlowContainer(navigationController:BaseNavigationController)->CurrencyListFlowCoordinator{
        return CurrencyListFlowCoordinator(navigationController: navigationController, dependecies: self)
    }
}


extension CurrencySceneDIContainer:CurrencyListFlowCoordinatorDependencies{}
