//
//  UIViewController+Kerabyte.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public override func enter(parent: UIResponder? = nil, completion: @escaping () -> Void) {
        if let parent = parent as? UIViewController {
            parent.present(self, animated: true, completion: completion)
        } else {
            guard let window = UIApplication.shared.delegate?.window else {
                return
            }
            
            window?.rootViewController = self
            window?.makeKeyAndVisible()
            completion()
        }
    }
    
}
