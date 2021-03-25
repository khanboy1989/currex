//
//  CurrencyListItemViewModel.swift
//  Currex
//
//  Created by Serhan Khan on 29/01/2021.
//

import Foundation
import UIKit.UIImage

struct CurrencyListItemViewModel {
    let sellRate:Double
    let currencyCode:String
    var currencyType:CurrencyType?{
        return currencyCode.toCurrencyType()
    }
    
    var calculatedAmount:String?
    
    mutating func changeAmount(calculatedAmount:String?){
        self.calculatedAmount = calculatedAmount
    }
}

enum CurrencyType:String{
    case aud = "AUD"
    case bgn = "BGN"
    case brl = "BRL"
    case cad = "CAD"
    case chf = "CHF"
    case cny = "CNY"
    case czk = "CZK"
    case eur = "EUR"
    case dkk = "DKK"
    case gbp = "GBP"
    case hkd = "HKD"
    case hrk = "HRK"
    case huf = "HUF"
    case idr = "IDR"
    case ils = "ILS"
    case inr = "INR"
    case isk = "ISK"
    case jpy = "JPY"
    case krw = "KRW"
    case mxn = "MXN"
    case myr = "MYR"
    case nok = "NOK"
    case nzd = "NZD"
    case php = "PHP"
    case pln = "PLN"
    case ron = "RON"
    case rub = "RUB"
    case sek = "SEK"
    case sgd = "SGD"
    case thb = "THB"
    case trl = "TRY"
    case usd = "USD"
    case zar = "ZAR"
    
    var image:UIImage?{
        switch self {
        case .aud:
            return Asset.Images.aud.image
        case .bgn:
            return Asset.Images.bgn.image
        case .brl:
            return Asset.Images.brl.image
        case.cad:
            return Asset.Images.cad.image
        case .chf:
            return Asset.Images.chf.image
        case .cny:
            return Asset.Images.cny.image
        case .czk:
            return Asset.Images.czk.image
        case .eur:
            return Asset.Images.eur.image
        case .dkk:
            return Asset.Images.dkk.image
        case .gbp:
            return Asset.Images.gbp.image
        case .hkd:
            return Asset.Images.hkd.image
        case .hrk:
            return Asset.Images.hrk.image
        case .huf:
            return Asset.Images.huf.image
        case .idr:
            return Asset.Images.idr.image
        case .ils:
            return Asset.Images.ils.image
        case .inr:
            return Asset.Images.inr.image
        case .isk:
            return Asset.Images.isk.image
        case .jpy:
            return Asset.Images.jpy.image
        case .krw:
            return Asset.Images.krw.image
        case .mxn:
            return Asset.Images.mxn.image
        case .myr:
            return Asset.Images.myr.image
        case .nok:
            return Asset.Images.nok.image
        case .nzd:
            return Asset.Images.nzd.image
        case .php:
            return Asset.Images.php.image
        case .pln:
            return Asset.Images.pln.image
        case .ron:
            return Asset.Images.ron.image
        case .rub:
            return Asset.Images.rub.image
        case .sek:
            return Asset.Images.sek.image
        case .sgd:
            return Asset.Images.sgd.image
        case .thb:
            return Asset.Images.thb.image
        case .trl:
            return Asset.Images.try.image
        case .usd:
            return Asset.Images.usd.image
        case .zar:
            return Asset.Images.zar.image
        }
    }
}

extension String{
    func toCurrencyType()->CurrencyType?{
        return CurrencyType.init(rawValue: self)
    }
}
