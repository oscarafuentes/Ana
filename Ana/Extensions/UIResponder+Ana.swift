//
//  UIResponder+Ana.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    
    private struct UIResponderAnaProperties {
        
        static var outlet: UIResponder? = nil
        static var component: AComponent? = nil
        static var active: Bool? = nil
        
    }
    
    public var outlet: UIResponder? {
        get {
            return objc_getAssociatedObject(self, &UIResponderAnaProperties.outlet) as? UIResponder
        }
        
        set {
            objc_setAssociatedObject(self, &UIResponderAnaProperties.outlet, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var component: AComponent? {
        get {
            guard let returnValue = objc_getAssociatedObject(self, &UIResponderAnaProperties.component) as? AComponent else {
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
            objc_setAssociatedObject(self, &UIResponderAnaProperties.component, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public internal(set) var active: Bool {
        get {
            return objc_getAssociatedObject(self, &UIResponderAnaProperties.active) as? Bool ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &UIResponderAnaProperties.active, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open func enter(_ parent: UIResponder? = nil, animated: Bool = true, completion: @escaping () -> Void) {
        completion()
    }
    
    open func leave(_ animated: Bool = true, completion: @escaping () -> Void) {
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
