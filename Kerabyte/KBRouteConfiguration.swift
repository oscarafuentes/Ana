//
//  KBRouteConfiguration.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation

public struct KBRouteConfiguration {
    
    public var component: KBComponent?
    public var match: Bool
    public var path: String?
    public var subRoutes: [KBRoute] = []
    
    public init(component: KBComponent? = nil, path: String? = nil, match: Bool = true, subRoutes: [KBRoute] = []) {
        self.component  = component
        self.match = match
        self.path = path
        self.subRoutes = subRoutes
    }
    
}
