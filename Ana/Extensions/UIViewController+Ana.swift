//
//  UIViewController+Ana.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import UIKit

public struct AViewControllerTransitionStyle {
    
    public static let navigation = 1
    public static let presentation = 2
    
}

extension UIViewController {
    
    open override func enter(_ parent: UIResponder? = nil, animated: Bool = true, completion: @escaping () -> Void) {
        if let parent = parent as? UIViewController {
            if self.transitionStyle() == AViewControllerTransitionStyle.navigation {
                // TODO: Handle case where tempalte is a UINavigationController
                if let navController = parent.navigationController {
                    navController.pushViewController(self, animated: animated)
                    completion()
                } else {
                    parent.present(UINavigationController(rootViewController: self), animated: animated, completion: completion)
                }
            } else {
                parent.present(self, animated: animated, completion: completion)
            }
        } else {
            guard let window = UIApplication.shared.delegate?.window else {
                return
            }
            
            window?.rootViewController = self.transitionStyle() == AViewControllerTransitionStyle.navigation ? UINavigationController(rootViewController: self) : self
            window?.makeKeyAndVisible()
            completion()
        }
    }
    
    open override func leave(_ animated: Bool = true, completion: @escaping () -> Void) {
        guard self.transitionStyle() == AViewControllerTransitionStyle.navigation else {
            self.dismiss(animated: animated, completion: completion)
            return
        }
        
        guard let navController = self.navigationController else {
            debugPrint("Attempting to leave from `navigation` transition style but no descendant navigation controller found.")
            return
        }
        
        guard let index = navController.viewControllers.index(of: self) else {
            debugPrint("Attempting to leave from `navigation` transition style but could not location self in navigation stack (hierarchy).")
            return
        }
        
        if index == 0 {
            navController.dismiss(animated: true, completion: completion)
        } else {
            navController.popToViewController(navController.viewControllers[index - 1], animated: true)
            completion()
        }
    }
    
    open func transitionStyle() -> Int {
        return AViewControllerTransitionStyle.navigation
    }
    
}
