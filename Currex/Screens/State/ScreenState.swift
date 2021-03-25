//
//  ScreenState.swift
//  Currex
//
//  Created by Serhan Khan on 27/01/2021.
//

import Foundation



enum ScreenState<T>{
    case loading
    case error(error:String)
    case noData
    case succes(data:T)
    case finished
}
