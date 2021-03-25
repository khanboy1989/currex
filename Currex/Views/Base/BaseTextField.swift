//
//  BaseTextField.swift
//  Currex
//
//  Created by Serhan Khan on 09/02/2021.
//

import UIKit
import Combine

class BaseTextField:UITextField{
    
    lazy var publishers = Publishers(textField: self)

    
    
}

extension BaseTextField{
    
    public class Publishers {
        private let textField:UITextField
        
        init(textField:UITextField) {
            self.textField = textField
        }
        
        private var notificationCenter:NotificationCenter = NotificationCenter.default
        
        public var text:AnyPublisher<String?, Never> {
            let textDidChangeByKeyboardPublisher = notificationCenter
                .publisher(for: UITextField.textDidChangeNotification, object: textField)
                .map { ($0.object as? UITextField)?.text }
                .eraseToAnyPublisher()
        
            let textDidChangeProgrammaticallyPublisher = KeyValueObservingPublisher(object: textField, keyPath: \.text, options: [.new])
                .eraseToAnyPublisher()
        
    
            return Combine.Publishers
                .Merge(textDidChangeProgrammaticallyPublisher, textDidChangeByKeyboardPublisher)
                .eraseToAnyPublisher()
        }
        
        
        
        public var isEditing:AnyPublisher<Bool, Never> {
            let begingEnditingPiblusher = notificationCenter
                .publisher(for: UITextField.textDidBeginEditingNotification, object: textField)
            let endEditingPublisher = notificationCenter
                .publisher(for: UITextField.textDidEndEditingNotification, object: textField)
            
            return Combine.Publishers.Merge(begingEnditingPiblusher, endEditingPublisher)
                .compactMap({($0.object as? UITextField)?.isEditing})
                .eraseToAnyPublisher()
        }
        
    }
}
