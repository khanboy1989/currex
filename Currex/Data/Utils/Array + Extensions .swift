//
//  Array + Extensions .swift
//  Currex
//
//  Created by Serhan Khan on 29/01/2021.
//

import Foundation


extension Array {
    func objectAt(index:Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
}
