//
//  BaseXIBView.swift
//  Currex
//
//  Created by Serhan Khan on 30/01/2021.
//

import Foundation
import UIKit
import Combine

open class BaseXIBView:UIView{
   
    var disposeBag = Set<AnyCancellable>()
    
    var contentView: UIView! {
        willSet {
            contentView?.removeFromSuperview()
            newValue.frame = bounds
            newValue.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            newValue.backgroundColor = .clear
            addSubview(newValue)
        }
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toSuperview: newWindow)
        didLoad()
    }
    
    public init() {
        super.init(frame:.zero)
        let objectName = String(describing: type(of:  self))
        initialization(nibName: objectName)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let objectName = String(describing: type(of:  self))
        initialization(nibName: objectName)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let objectName = String(describing: type(of:  self))
        initialization(nibName: objectName)
    }
    
    open func didLoad(){
        self.configureObsersvers()
    }
    
    open func prefferedBundle() -> Bundle? {
        return Bundle.init(for: BaseXIBView.self)
    }
    
    open func initialization(nibName:String) {
        let nib = UINib(nibName: nibName, bundle: prefferedBundle())
        let view = (nib.instantiate(withOwner: self, options: nil).first as? UIView) ?? UIView()
        contentView = view
    }
    
    open func configureObsersvers(){}
    
    deinit {
        disposeBag.forEach{$0.cancel()}
        disposeBag.removeAll()
    }
}
