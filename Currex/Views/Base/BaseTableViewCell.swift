//
//  BaseTableViewCell.swift
//  Currex
//
//  Created by Serhan Khan on 28/01/2021.
//

import Foundation
import UIKit


class BaseTableViewCell:UITableViewCell{
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
