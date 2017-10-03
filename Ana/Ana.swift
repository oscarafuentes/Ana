//
//  Ana.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import UIKit

public final class Ana {
    
    /**
     Privately shared instance of top-level module class.
     */
    
    public static let shared = Ana()
    
    /**
     The active route.
     */
    
    public let url = AObservable<URL>(URL(string: "/")!)
    
    /**
     The router which manages this application.
     */
    
    private var router: ARouter?
    
    /**
     The stack of active routes.
     */
    
    private var routeStack: [ARoute] = []
    
    /**
     The stack of active route components.
     */
    
    private var componentStack: [AComponent] = []
    
    /**
     The active route.
     */
    
    private var activeRoute: ARoute?
    
    private var historyStack: [URL] = []
    
    /**
     Registers a router for path resolution, redirection, etc.
     
     - Parameter router: The router which manages this application.
     */
    
    public static func register(_ router: ARouter, url: URL = URL(string: "/")!) {
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
        
        guard let routeStack = shared.generate(path.pathComponents, route: router.route) else {
            return
        }
        
        let toRemove = shared.routeStack.filter { route -> Bool in
            return routeStack.index(of: route) == nil
        }
        
        let toAdd = routeStack.filter { route -> Bool in
            return shared.routeStack.index(of: route) == nil
        }
        
        shared.routeStack = shared.routeStack.filter { route -> Bool in
            return toRemove.index(of: route) == nil
        }
        
        shared.routeStack.append(contentsOf: toAdd)
        
        shared.leave(toRemove) {
            let parentTemplate = shared.componentStack.last?.template
            shared.enter(toAdd, parent: parentTemplate)
        }
        
        shared.url.value = url
        shared.activeRoute = shared.routeStack.last
        shared.historyStack.append(url)
    }
    
    /**
     Generate the responder hierarchy.
     
     - Parameter components: The activity which should be resolved (designated url).
     - Parameter route: The activity which should be resolved (designated url).
     */
    
    
    private func generate(_ components: [String], route: ARoute) -> [ARoute]? {
        var returnValue: [ARoute]?
        var childRoutes: [ARoute]?
        
        var duplicate = components.map { component -> String in
            return component.replacingOccurrences(of: "/", with: "")
        }.filter { component -> Bool in
            return !component.isEmpty
        }
        
        let path        = route.path
        let subRoutes   = route.subRoutes
        
        let routePath   = path?.replacingOccurrences(of: "/", with: "")
        
        if let routePath = routePath, duplicate.count > 0 {
            if routePath == ARoutePredefined.root.rawValue || routePath == ARoutePredefined.wildcard.rawValue {
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
            if routePath == ARoutePredefined.root.rawValue || routePath == ARoutePredefined.wildcard.rawValue {
                returnValue = [route]
            }
        } else {
            returnValue = [route]
            
            for subRoute in subRoutes {
                let subRoutePath = subRoute.path?.replacingOccurrences(of: "/", with: "").lowercased()
                
                if duplicate.count > 0 {
                    if subRoutePath == duplicate[0] {
                        childRoutes = self.generate(duplicate, route: subRoute)
                    }
                }
                
                if subRoutePath == ARoutePredefined.root.rawValue || subRoutePath == ARoutePredefined.wildcard.rawValue {
                    childRoutes = self.generate(duplicate, route: subRoute)
                }
                
                if childRoutes != nil {
                    break
                }
            }
        }
        
        if let routes = childRoutes {
            returnValue?.append(contentsOf: routes)
        }
        
        return returnValue
    }
    
    private func enter(_ routes: [ARoute], parent: UIResponder?, completion: (() -> Void)? = nil) {
        guard let first = routes.first else {
            completion?()
            return
        }
        
        let component = first.generateComponent()
        component.template.onInit()
        component.template.enter(parent) {
            self.componentStack.append(component)
            self.enter(Array(routes.dropFirst()), parent: self.componentStack.last?.template, completion: completion)
        }
    }
    
    private func leave(_ routes: [ARoute], completion: (() -> Void)? = nil) {
        if routes.last == nil {
            completion?()
            return
        }
        
        let component = self.componentStack.removeLast()
        component.onDestroy()
        component.template.leave {
            self.leave(Array(routes.dropLast()), completion: completion)
        }
    }
    
    /**
     Dispatches a route signal for the given activity's designated url.
     
     - Parameter activity: The activity which should be resolved (designated url).
     */
    
    public static func dispatch(_ activity: NSUserActivity) {
        
    }
    
}
