//
//  UITableViewCell + Extensions.swift
//  Currex
//
//  Created by Serhan Khan on 28/01/2021.
//

import Foundation
import UIKit


extension UITableViewCell {

    static var identifier:String {
        return String(describing: self)
    }
    
    static func create(tableView:UITableView,reuseIdentifier:String? = nil) -> Self {
        return create(tableView: tableView, reuseIdentifier: (reuseIdentifier ?? identifier), type: self)
    }
    
    fileprivate static func create<T : UITableViewCell>(tableView:UITableView,reuseIdentifier:String,type: T.Type) -> T {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T else {
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
            return create(tableView: tableView,reuseIdentifier:reuseIdentifier, type: type)
        }
        
        return cell

    }
}
