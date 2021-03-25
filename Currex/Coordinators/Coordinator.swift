//
//  Coordinator.swift
//  Currex
//
//  Created by Serhan Khan on 10/01/2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController:BaseNavigationController{get set}
    func start()
}
