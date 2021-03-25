//
//  ExchangeRateInputTextFieldContainer.swift
//  Currex
//
//  Created by Serhan Khan on 30/01/2021.
//

import Foundation
import UIKit
import Combine

class ExchangeRateInputTextFieldContainer:BaseXIBView{
    
    private var maximumDigitsAllowed:Int = 14
    
    var amount:String?{
        set{
            amountTextField.text = newValue
        }get{
            return amountTextField.text
        }
    }
    
    @IBOutlet weak var containerView:UIView!{
        willSet{
            newValue.backgroundColor = Asset.Colors.black.color
            newValue.layer.cornerRadius = 9
        }
    }
    
    @IBOutlet weak var amountTextField:BaseTextField!{
        willSet{
            newValue.attributedPlaceholder = NSAttributedString(string: L10n.zeroZero,attributes: [.foregroundColor: Asset.Colors.lightGray.color,.font: Fonts.system(ofSize: 20, weight: .bold)])
            newValue.keyboardType = .numberPad
            newValue.textColor = Asset.Colors.white.color
            newValue.font = Fonts.system(ofSize: 20, weight: .bold)
            newValue.backgroundColor = .clear
            newValue.textAlignment = .right
            newValue.tintColor = Asset.Colors.white.color
            newValue.delegate = self
        }
    }
    
    @IBOutlet weak var currencyCodeLabel:UILabel!{
        willSet{
            newValue.font = Fonts.system(ofSize: 20, weight: .bold)
            newValue.backgroundColor = .clear
            newValue.textAlignment = .left
            newValue.numberOfLines = 1
            newValue.textColor = Asset.Colors.white.color
        }
    }
    
    @IBOutlet weak var exchangeRateImageView:UIImageView!{
        willSet{
            newValue.contentMode = .scaleAspectFit
            newValue.layer.cornerRadius = newValue.frame.width / 2.0
        }
    }
    
    var currencyListItemViewModel:CurrencyListItemViewModel?{
        willSet{
            currencyCodeLabel.text = newValue?.currencyCode
            UIView.transition(with: exchangeRateImageView, duration: 0.2, options: .transitionFlipFromTop, animations: {
                self.exchangeRateImageView.image = newValue?.currencyType?.image
            },completion:nil)
        }
    }
    
    override func initialization(nibName: String) {
        super.initialization(nibName: String(describing: ExchangeRateInputTextFieldContainer.self))
    }
    
    var textDidChange:AnyPublisher<String?,Never>{
        return amountTextField.publishers.text.eraseToAnyPublisher()
    }
}


extension ExchangeRateInputTextFieldContainer: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let point = Locale.current.decimalSeparator!
        let decSep = Locale.current.groupingSeparator!
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.maximumIntegerDigits = maximumDigitsAllowed
        formatter.locale = Locale.current
        formatter.roundingMode = .floor
        
        let text = textField.text!
        let textRange = Range(range, in: text)!
        
        var fractionLength = 0
        var isRangeUpperPoint = false
        
        if let startPoint = text.lastIndex(of: point.first!) {
            let end = text.endIndex
            let str = String(text[startPoint..<end])
            fractionLength = str.count
            isRangeUpperPoint = textRange.lowerBound >= startPoint
        }
        
        if  fractionLength == 3 && string != "" && isRangeUpperPoint {
            return false
        }
        
        let r = (textField.text! as NSString).range(of: point).location < range.location
        if (string == "0" || string == "") && r {
            return true
        }
        
        // First check whether the replacement string's numeric...
        let cs = NSCharacterSet(charactersIn: "0123456789\(point)").inverted
        let filtered = string.components(separatedBy: cs)
        let component = filtered.joined(separator: "")
        let isNumeric = string == component
        
        
        if isNumeric {
        
            // Combine the new text with the old; then remove any
            // commas from the textField before formatting
            let newString = text.replacingCharacters(in: textRange,  with: string)

            let numberWithOutCommas = newString.replacingOccurrences(of: decSep, with: "")
            let number = formatter.number(from: numberWithOutCommas)
            if number != nil {
                var formattedString = formatter.string(from: number!)
                // If the last entry was a decimal or a zero after a decimal,
                // re-add it here because the formatter will naturally remove
                // it.
                
                if let numberString = number?.toString(), string != decSep, numberString != "", numberString.count == maximumDigitsAllowed {
                    return false
                }

                if string == point && range.location == textField.text?.count {
                    formattedString = formattedString?.appending(point)
                }
                textField.text = formattedString
            } else {
                textField.text = nil
            }
        }

        return false
    }
}

extension NSNumber{
    
    func toString()->String?{
        return String(describing:self)
    }
}


