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
    
    private var router: KBRouter?
    
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
    
    public static func register(_ router: KBRouter, url: URL = URL(string: "/")!) {
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
        
        guard let path = URL(string: absoluteString) else {
            return
        }
        
        guard let routes = shared.generate(path.pathComponents, route: router.route) else {
            return
        }
        
        print(routes)
    }
    
    /**
     Generate the responder hierarchy.
     
     - Parameter components: The activity which should be resolved (designated url).
     - Parameter route: The activity which should be resolved (designated url).
     */
    
    
    private func generate(_ components: [String], route: KBRoute) -> [KBRoute]? {
        var returnValue: [KBRoute]?
        var childRoutes: [KBRoute]?
        
        var duplicate = components.map { component -> String in
            return component.replacingOccurrences(of: "/", with: "")
        }
        
        duplicate = duplicate.filter { component -> Bool in
            return !component.isEmpty
        }
        
        let path        = route.path
        let subRoutes   = route.subRoutes
        
        let routePath   = path?.replacingOccurrences(of: "/", with: "")
        
        if let routePath = routePath, duplicate.count > 0 {
            if routePath == KBRoutePredefined.root.rawValue || routePath == KBRoutePredefined.wildcard.rawValue {
                returnValue = [route]
            } else if routePath == duplicate[0] {
                returnValue = [route]
                duplicate.removeFirst()
            }
            
            if returnValue != nil && duplicate.count > 0 {
                for subRoute in subRoutes {
                    childRoutes = self.generate(duplicate, route: subRoute)
                    if childRoutes != nil {
                        break
                    }
                }
                
                if childRoutes == nil {
                    returnValue = nil
                }
            }
        } else if let routePath = routePath {
            if routePath == KBRoutePredefined.root.rawValue || routePath == KBRoutePredefined.wildcard.rawValue {
                returnValue = [route]
            }
        } else {
            returnValue = [route]
            
            if returnValue != nil {
                for subRoute in subRoutes {
                    let subRoutePath = subRoute.path?.replacingOccurrences(of: "/", with: "").lowercased()
                    
                    if duplicate.count > 0 {
                        if subRoutePath == duplicate[0] {
                            childRoutes = self.generate(duplicate, route: subRoute)
                        }
                    }
                    
                    if subRoutePath == KBRoutePredefined.root.rawValue || subRoutePath == KBRoutePredefined.wildcard.rawValue {
                        childRoutes = self.generate(duplicate, route: subRoute)
                    }
                    
                    if childRoutes != nil {
                        break
                    }
                }
            }
        }
        
        if let routes = childRoutes {
            returnValue?.append(contentsOf: routes)
        }
        
        return returnValue
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
    
}
