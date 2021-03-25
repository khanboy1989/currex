//
//  RepositoryTask.swift
//  Currex
//
//  Created by Serhan Khan on 25/01/2021.
//

import Foundation


class RepositoryTask:Cancellable{
    var networkTask:NetworkCancellable?
    var isCancelled:Bool = false
    
    func cancel(){
        networkTask?.cancel()
        isCancelled = true 
    }
}
