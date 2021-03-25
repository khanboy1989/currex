//
//  AppCoordinator.swift
//  Currex
//
//  Created by Serhan Khan on 10/01/2021.
//

import Foundation
import UIKit



class AppFlowCoordinator:Coordinator{

    fileprivate let window:UIWindow
    private let appDIContainer:AppDIContainer
    var navigationController: BaseNavigationController
   
    init(window:UIWindow,appDIContainer:AppDIContainer,navigationController:BaseNavigationController){
        self.window = window
        self.appDIContainer = appDIContainer
        self.navigationController = navigationController
    }
    
    func start() {
        self.window.rootViewController = navigationController
        let currencySceneDIContainer = appDIContainer.makeCurrencySceneDIContainer()
        let flow = currencySceneDIContainer.makeCurrencyListFlowContainer(navigationController: navigationController)
        flow.start()
    }
}


