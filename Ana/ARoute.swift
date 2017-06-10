//
//  ARoute.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation

open class ARoute: NSObject {
        
    public var match: Bool
    public var path: String?
    public var subRoutes: [ARoute] = []
    
    public init(_ path: String? = nil, match: Bool = true, subRoutes: [ARoute] = []) {
        self.match = match
        self.path = path
        self.subRoutes = subRoutes
        super.init()
    }
    
    open func generateComponent() -> AComponent {
        return AComponent()
    }
    
}
