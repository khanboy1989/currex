//
//  CurrencyConverterFlowCoordinator.swift
//  Currex
//
//  Created by Serhan Khan on 10/01/2021.
//

import Foundation
import UIKit


protocol CurrencyListFlowCoordinatorDependencies{
    func makeCurrencyListViewController(actions:CurrencyListViewModelActios)->CurrencyListViewController
}

class CurrencyListFlowCoordinator:Coordinator{
    var navigationController: BaseNavigationController
    let dependecies:CurrencyListFlowCoordinatorDependencies
    
    init(navigationController:BaseNavigationController,dependecies:CurrencyListFlowCoordinatorDependencies){
        self.navigationController = navigationController
        self.dependecies = dependecies
    }
    
    func start() {
       let actions = CurrencyListViewModelActios(pop: pop)
        let vc = dependecies.makeCurrencyListViewController(actions: actions)
        self.navigationController.setViewControllers([vc], animated: true)
    }
    
    func pop(){
       
    }
}
