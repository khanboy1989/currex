//
//  ConnectionError.swift
//  Currex
//
//  Created by Serhan Khan on 21/01/2021.
//

import Foundation


public protocol ConnectionError:Error{
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
