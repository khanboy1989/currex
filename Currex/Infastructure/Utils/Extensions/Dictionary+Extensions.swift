//
//  Dictionary+Extensions.swift
//  Currex
//
//  Created by Serhan Khan on 17/01/2021.
//

import Foundation


//MARK: - Dictionary Extensions 
public extension Dictionary{
    var queryString:String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
