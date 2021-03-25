//
//  ExchangeRates.swift
//  Currex
//
//  Created by Serhan Khan on 19/01/2021.
//

import Foundation


struct ExchangeRates:Decodable {
    let base:String
    let date:String
    let rates:[String:Double]
}

