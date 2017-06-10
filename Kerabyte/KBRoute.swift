//
//  KBRoute.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation

open class KBRoute: NSObject {
        
    public var match: Bool
    public var path: String?
    public var subRoutes: [KBRoute] = []
    
    public init(_ path: String? = nil, match: Bool = true, subRoutes: [KBRoute] = []) {
        self.match = match
        self.path = path
        self.subRoutes = subRoutes
        super.init()
    }
    
    public func component() -> KBComponent {
        return KBComponent()
    }
    
}
