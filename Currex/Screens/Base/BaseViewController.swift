//
//  BaseViewController.swift
//  Currex
//
//  Created by Serhan Khan on 28/01/2021.
//

import Foundation
import UIKit
import Combine

class BaseViewController:UIViewController,Alertable{
    
    var disposeBag = Set<AnyCancellable>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        executeRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    open func executeRequests(){
        
    }
    
    open func configureObservers(){
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag.forEach{$0.cancel()}
        disposeBag.removeAll()
    }
    
    open func didReceiveNetworkError(error:String){
        showAlert(message: error)
    }
}
