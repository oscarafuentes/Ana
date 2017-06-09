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
    
    public private(set) var template: UIResponder
    
    public init(_ template: UIResponder) {
        self.template = template
        super.init()
        self.configure()
    }
    
    open func configure() {
        self.template.component = self
        self.template.onInit()
    }
    
    /**
     Lifecycle Hooks
     */
    
    open func onInit() {
        
    }
    
    open func onDestroy() {
        
    }
    
}
