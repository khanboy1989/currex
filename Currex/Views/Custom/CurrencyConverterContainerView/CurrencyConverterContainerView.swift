//
//  CurrencyConverterContainerView.swift
//  Currex
//
//  Created by Serhan Khan on 30/01/2021.
//

import Foundation
import UIKit
import Combine

class CurrencyConverterContainerView:BaseXIBView{
    
    var fromtextDidChange = PassthroughSubject<String?,Never>()

    @IBOutlet weak var fromExchangeRateTextFieldContainer:ExchangeRateInputTextFieldContainer!
    
    
    @IBOutlet weak var baseCurrencyImageView:UIImageView!{
        willSet{
            newValue.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var baseCurrencyLabel:UILabel!{
        willSet{
            newValue.font = Fonts.system(ofSize: 17, weight: .semibold)
            newValue.textAlignment = .right
            newValue.textColor = Asset.Colors.white.color
        }
    }
    
    var fromExchangeRate:CurrencyListItemViewModel?{
        willSet{
            fromExchangeRateTextFieldContainer.currencyListItemViewModel = newValue
            baseCurrencyImageView.image = newValue?.currencyType?.image
            guard let currencyCode = newValue?.currencyCode.nullify else {return}
            baseCurrencyLabel.text = "1 \(currencyCode)"
        }
    }
    
    override func initialization(nibName: String) {
        super.initialization(nibName: String(describing: CurrencyConverterContainerView.self))
    }
    
    override func didLoad() {
        super.didLoad()
        contentView.backgroundColor = .black
    }
    
    override func configureObsersvers() {
        super.configureObsersvers()
        fromExchangeRateTextFieldContainer.amountTextField.publishers.text.sink(receiveValue: fromTextFieldDidChange).store(in: &disposeBag)
    }
    
    private func fromTextFieldDidChange(value:String?){
        self.fromtextDidChange.send(value)
        guard let currencyCode = fromExchangeRate?.currencyCode.nullify else {return}
        guard let amount = value?.nullify else {
        baseCurrencyLabel.text = "1 \(currencyCode)";return}
        baseCurrencyLabel.text = "\(amount) \(currencyCode)"
    }
    
    func resetFromTextFieldText(value:String?){
        self.fromExchangeRateTextFieldContainer.amount = value
    }
}


