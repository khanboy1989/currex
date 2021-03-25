//
//  UIViewController+AddChild.swift
//  Currex
//
//  Created by Serhan Khan on 12/01/2021.
//

import Foundation
import UIKit


extension UIViewController{

    //MARK: - add
    func add(child:UIViewController,container:UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    //MARK: - remove
    func remove(){
        guard parent != nil else {return}
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
}
