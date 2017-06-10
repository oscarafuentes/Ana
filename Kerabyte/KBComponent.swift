//
//  KBComponent.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import UIKit

open class KBComponent: NSObject {
    
    open func configure() {
        
    }
    
    public func template() -> UIResponder {
        return UIResponder()
    }
    
    /**
     Lifecycle Hooks
     */
    
    open func onInit() {
        
    }
    
    open func onDestroy() {
        
    }
    
}
