//
//  BaseTableView.swift
//  Currex
//
//  Created by Serhan Khan on 28/01/2021.
//

import Foundation
import UIKit

class BaseTableView:UITableView{
    

    override func awakeFromNib() {
        super.awakeFromNib()
        separatorStyle = .none
    }
}
