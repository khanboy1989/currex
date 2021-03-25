//
//  Encode+Extensions.swift
//  Currex
//
//  Created by Serhan Khan on 17/01/2021.
//

import Foundation


//MARK:- Encodable Extensions
public extension Encodable{
    func toDictionary() throws -> [String:Any]?{
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String:Any]
    }
}
