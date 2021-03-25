//
//  UIViewController+AddBehaviors.swift
//  Currex
//
//  Created by Serhan Khan on 12/01/2021.
//

import Foundation
import UIKit

// View controller lifecycle behaviors https://irace.me/lifecycle-behaviors
// Behaviors are very useful to reuse logic for cases like Keyboard Behaviour.
// Where ViewController on didLoad adds behaviour which observes keyboard frame
// and scrollView content inset changes based on keyboard frame.


//MARK: - ViewController Lifecycle Behavior
protocol ViewControllerLifecycleBehavior{
    func viewDidLoad(viewController:UIViewController)
    func viewWillAppear(viewController:UIViewController)
    func viewDidAppear(viewController:UIViewController)
    func viewWillDisappear(viewController:UIViewController)
    func viewDidDisappear(viewController:UIViewController)
    func viewWillLayoutSubviews(viewController:UIViewController)
    func viewDidLayourSubviews(viewController:UIViewController)
}

//MARK: - Default Implementation
extension ViewControllerLifecycleBehavior{
    func viewDidLoad(viewController:UIViewController){}
    func viewWillAppear(viewController:UIViewController){}
    func viewDidAppear(viewController:UIViewController){}
    func viewWillDisappear(viewController:UIViewController){}
    func viewDidDisappear(viewController:UIViewController){}
    func viewWillLayoutSubviews(viewController:UIViewController){}
    func viewDidLayourSubviews(viewController:UIViewController){}
}


extension UIViewController{
    
    /*
     Add behaviors to be hooked into this view controller’s lifecycle.
     
     This method requires the view controller’s view to be loaded, so it’s best to call
     in `viewDidLoad` to avoid it being loaded prematurely.
     
     - parameter behaviors: Behaviors to be added.
     */
    
    func addBehaviors(_ behaviors:[ViewControllerLifecycleBehavior]){
        let behaviorViewController = LifecycleBehaviorViewController(behaviors: behaviors)
        
        addChild(behaviorViewController)
        view.addSubview(behaviorViewController.view)
        behaviorViewController.didMove(toParent: self)
    }
    
    private final class LifecycleBehaviorViewController:UIViewController,UIGestureRecognizerDelegate{
        
        private let behaviors:[ViewControllerLifecycleBehavior]
        
        init(behaviors:[ViewControllerLifecycleBehavior]){
            self.behaviors = behaviors
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: - viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            view.isHidden = true
            applyBehaviors{behavior,viewController in
                behavior.viewDidLoad(viewController: viewController)
            }
        }
     
        //MARK: - viewWillAppear
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            applyBehaviors{behavior, viewController in
                behavior.viewWillAppear(viewController: viewController)
            }
        }
        
        //MARK: - viewDidAppear
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            applyBehaviors{behavior, viewController in
                behavior.viewDidAppear(viewController: viewController)
            }
        }
        
        //MARK: - viewWillDisappear
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            applyBehaviors{behavior,viewController in
                behavior.viewWillDisappear(viewController: viewController)
            }
        }
        
        //MARK: - viewDidDisappear
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidAppear(animated)
            applyBehaviors{behavior,viewController in
                behavior.viewDidDisappear(viewController: viewController)
            }
        }
        
        //MARK: - viewWillLayoutSubviews
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            applyBehaviors{behavior, viewController in
                behavior.viewWillLayoutSubviews(viewController: viewController)
            }
        }
        
        //MARK: - viewDidLayoutSubviews
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            applyBehaviors{behavior,viewController in
                behavior.viewDidLayourSubviews(viewController: viewController)
            }
        }
           
        //MARK: - applyBehaviors
        private func applyBehaviors(_ body: (_ behavior: ViewControllerLifecycleBehavior, _ viewController:UIViewController)->Void) {
            guard let parent = parent else {return}
            for behavior in behaviors{
                body(behavior,parent)
            }
        }
    }
    
}
