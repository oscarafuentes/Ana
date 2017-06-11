//
//  ARouter.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation

open class ARouter {
    
    public private(set) var route: ARoute
    public private(set) var domains: [String]
    
    public init(_ route: ARoute, domains: [String] = []) {
        self.route = route
        self.domains = domains
    }
    
}
