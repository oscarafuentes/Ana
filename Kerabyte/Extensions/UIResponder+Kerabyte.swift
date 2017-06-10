//
//  UIResponder+Kerabyte.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    
    private struct UIResponderKerabyteProperties {
        
        static var outlet: UIResponder? = nil
        static var component: KBComponent? = nil
        static var active: Bool? = nil
        
    }
    
    public var outlet: UIResponder? {
        get {
            return objc_getAssociatedObject(self, &UIResponderKerabyteProperties.outlet) as? UIResponder
        }
        
        set {
            objc_setAssociatedObject(self, &UIResponderKerabyteProperties.outlet, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var component: KBComponent? {
        get {
            guard let returnValue = objc_getAssociatedObject(self, &UIResponderKerabyteProperties.component) as? KBComponent else {
                if let view = self as? UIView {
                    var parent = view.superview
                    
                    while parent != nil {
                        if let parentComponent = parent?.component {
                            return parentComponent
                        }
                        
                        parent = parent?.superview
                    }
                }
                
                return nil
            }
            
            return returnValue
        }
        
        set {
            objc_setAssociatedObject(self, &UIResponderKerabyteProperties.component, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public internal(set) var active: Bool {
        get {
            return objc_getAssociatedObject(self, &UIResponderKerabyteProperties.active) as? Bool ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &UIResponderKerabyteProperties.active, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func enter(parent: UIResponder? = nil, completion: @escaping () -> Void) {
        completion()
    }
    
    public func leave(completion: @escaping () -> Void) {
        completion()
    }
    
    internal func refresh() {
        if let view = self as? UIView {
            for subview in view.subviews {
                subview.refresh()
            }
        } else if let controller = self as? UIViewController {
            controller.view.refresh()
        }
    }
    
    internal func dynamicKeys() -> [String: String] {
        return [:]
    }
    
    open func onInit() {
        
    }
    
}
