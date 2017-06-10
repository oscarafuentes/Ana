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
    
    public private(set) var template: UIResponder!
    
    public override init() {
        super.init()
        self.template = self.generateTemplate()
    }
    
    open func configure() {
        
    }
    
    open func generateTemplate() -> UIResponder {
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
