//
//  AppConfiguration.swift
//  Currex
//
//  Created by Serhan Khan on 11/01/2021.
//

import Foundation


final class AppConfiguration{
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = PlistFiles.apiBaseURL.nullify else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
