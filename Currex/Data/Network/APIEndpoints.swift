//
//  ApiEndpoints.swift
//  Currex
//
//  Created by Serhan Khan on 19/01/2021.
//

import Foundation



struct APIEndpoints{
    
    static func getExchangeRates(for base:String)->Endpoint<ExchangeRates>{
        return Endpoint(path: "latest",method: .get, queryParameters:["base":base, "access_key": PlistFiles.accessKey])
    }
}
