//
//  AppAppearance.swift
//  Currex
//
//  Created by Serhan Khan on 11/01/2021.
//

import Foundation
import UIKit

final class AppAppearance{
    static func setupAppearance(){
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
}

