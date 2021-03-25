//
//  BaseNavigationViewController.swift
//  Currex
//
//  Created by Serhan Khan on 11/01/2021.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
