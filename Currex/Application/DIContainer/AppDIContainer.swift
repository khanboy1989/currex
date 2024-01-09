//
//  AppDIContainer.swift
//  Currex
//
//  Created by Serhan Khan on 15/01/2021.
//

import Foundation


final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(networkService: apiDataNetwork)
    }()
    
    
    //MARK: - DIContainers of Screens
    func makeCurrencySceneDIContainer()->CurrencySceneDIContainer{
        return CurrencySceneDIContainer(dependecies: CurrencySceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService))
    }
}
