//
//  Kerabyte.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation

public final class Kerabyte {
    
    /**
     Privately shared instance of top-level module class.
     */
    
    public static let shared = Kerabyte()
    
    /**
     The active route.
     */
    
    public let url = KBObservable<URL>(URL(string: "/")!)
    
    /**
     The router which manages this application.
     */
    
    private var router: KBRouter<KBRoute>?
    
    /**
     The stack of active route responders.
     */
    
    private var responderStack: [UIResponder]  = []
    
    /**
     The active responder.
     */
    
    private var activeResponder: UIResponder? {
        willSet {
            self.activeResponder?.active = false
        }
        
        didSet {
            self.activeResponder?.active = true
        }
    }
    
    private var historyStack: [URL] = []
    
    /**
     Registers a router for path resolution, redirection, etc.
     
     - Parameter router: The router which manages this application.
     */
    
    public static func register(_ router: KBRouter<KBRoute>, url: URL = URL(string: "/")!) {
        shared.router = router
        
        dispatch(url)
    }
    
    /**
     Dispatches a route signal for the given url.
     
     - Parameter url: The url that should be resolved.
     */
    
    public static func dispatch(_ url: URL) {
        guard let router = shared.router else {
            return
        }
        
        var absoluteString = url.absoluteString.lowercased()
        
        for domain in router.domains {
            absoluteString = absoluteString.replacingOccurrences(of: domain, with: "")
        }
        
        guard let next = URL(string: absoluteString) else {
            return
        }
        
        let active = shared.url.value
        
        
        
//        guard let path = URL(string: absoluteString) else {
//            return
//        }
//        
//        guard let template = shared.generate(path.pathComponents, route: router.route) else {
//            return
//        }
//        
//        var outlet: UIResponder? = template
//        
//        var outletStack: [UIResponder] = []
//        while let responder = outlet {
//            outletStack.append(responder)
//            outlet = responder.outlet
//        }
//        
//        let toRemove = shared.responderStack.filter { responder -> Bool in
//            return outletStack.index(of: responder) == nil
//        }
//        
//        let toAdd = outletStack.filter { responder -> Bool in
//            return shared.responderStack.index(of: responder) == nil
//        }
//        
//        shared.responderStack = shared.responderStack.filter { responder -> Bool in
//            return toRemove.index(of: responder) == nil
//        }
//        
//        let parent = shared.responderStack.last
//        
//        shared.responderStack.append(contentsOf: toAdd)
//        
//        shared.leave(toRemove) {
//            shared.enter(toAdd, parent: parent)
//        }
//        
//        shared.url.value = url
//        shared.activeResponder = shared.responderStack.last
//        shared.historyStack.append(url)
    }
    
    private func enter(_ responders: [UIResponder], parent: UIResponder?, completion: (() -> Void)? = nil) {
        guard let first = responders.first else {
            completion?()
            return
        }
        
        first.component?.onInit()
        
        first.enter(parent: parent) {
            var duplicate = responders
            let subParent = duplicate.removeFirst()
            self.enter(duplicate, parent: subParent, completion: completion)
        }
    }
    
    private func leave(_ responders: [UIResponder], completion: (() -> Void)? = nil) {
        guard let last = responders.last else {
            completion?()
            return
        }
        
        last.component?.onDestroy()
        
        last.leave {
            var duplicate = responders
            duplicate.removeLast()
            self.leave(duplicate, completion: completion)
        }
    }
    
    /**
     Dispatches a route signal for the given activity's designated url.
     
     - Parameter activity: The activity which should be resolved (designated url).
     */
    
    public static func dispatch(_ activity: NSUserActivity) {
        
    }
    
    /**
     Generate the responder hierarchy.
     
     - Parameter components: The activity which should be resolved (designated url).
     - Parameter route: The activity which should be resolved (designated url).
     */
    
    private func generate(_ components: [String], route: KBRoute) -> UIResponder? {
        var returnValue: UIResponder?
        var subTemplate: UIResponder?
        
        var duplicate = components.map { component -> String in
            return component.replacingOccurrences(of: "/", with: "")
        }
        
        duplicate = duplicate.filter { component -> Bool in
            return !component.isEmpty
        }
        
        let path        = route.configuration.path
        let component   = route.configuration.component
        let subRoutes   = route.configuration.subRoutes
        
        let routePath   = path?.replacingOccurrences(of: "/", with: "")
        
        if let routePath = routePath, duplicate.count > 0 {
            if routePath == KBRoutePredefined.root.rawValue || routePath == KBRoutePredefined.wildcard.rawValue {
                returnValue = component?.template
            } else if routePath == duplicate[0] {
                returnValue = component?.template
                duplicate.removeFirst()
            }
            
            if returnValue != nil && duplicate.count > 0 {
                for subRoute in subRoutes {
                    subTemplate = self.generate(duplicate, route: subRoute)
                    if subTemplate != nil {
                        break
                    }
                }
                
                if subTemplate == nil {
                    returnValue = nil
                }
            }
        } else if let routePath = routePath {
            if routePath == KBRoutePredefined.root.rawValue || routePath == KBRoutePredefined.wildcard.rawValue {
                returnValue = component?.template
            }
        } else {
            returnValue = component?.template
            
            if returnValue != nil {
                for subRoute in subRoutes {
                    let subRoutePath = subRoute.configuration.path?.replacingOccurrences(of: "/", with: "").lowercased()
                    
                    if duplicate.count > 0 {
                        if subRoutePath == duplicate[0] {
                            subTemplate = self.generate(duplicate, route: subRoute)
                        }
                    }
                    
                    if subRoutePath == KBRoutePredefined.root.rawValue || subRoutePath == KBRoutePredefined.wildcard.rawValue {
                        subTemplate = self.generate(duplicate, route: subRoute)
                    }
                    
                    if subTemplate != nil {
                        break
                    }
                }
            }
        }
        
        returnValue?.outlet = subTemplate
        
        return returnValue
    }
    
}
