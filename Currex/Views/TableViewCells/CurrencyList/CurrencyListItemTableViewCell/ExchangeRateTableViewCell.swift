//
//  ExchangeRateTableViewCell.swift
//  Currex
//
//  Created by Serhan Khan on 28/01/2021.
//

import UIKit

class ExchangeRateTableViewCell: BaseTableViewCell {

    @IBOutlet weak var currencyImageView:UIImageView!{
        willSet{
            newValue.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var currencyCodeLabel:UILabel!{
        willSet{
            newValue.font = .systemFont(ofSize: 15, weight: .semibold)
            newValue.textAlignment = .left
            newValue.textColor = Asset.Colors.white.color
        }
    }
    @IBOutlet weak var sellRateLabel:UILabel!{
        willSet{
            newValue.font = .systemFont(ofSize: 15, weight: .semibold)
            newValue.textAlignment = .right
            newValue.textColor = Asset.Colors.white.color
        }
    }
    
    private var currenyListItemViewModel:CurrencyListItemViewModel!{
        willSet{
            currencyImageView.image = newValue.currencyType?.image
            currencyCodeLabel.text = newValue.currencyCode
            guard newValue.calculatedAmount?.nullify != nil else {
                sellRateLabel.text = String(format: "%.2f", newValue.sellRate);return}
            sellRateLabel.text = newValue.calculatedAmount
        }
    }
    
    static func create(tableView:UITableView,currecyListItemViewModel:CurrencyListItemViewModel)-> ExchangeRateTableViewCell {
        let cell = ExchangeRateTableViewCell.create(tableView: tableView)
        cell.currenyListItemViewModel = currecyListItemViewModel
        return cell
    }
}
