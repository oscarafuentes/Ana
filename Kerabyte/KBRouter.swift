//
//  KBRouter.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation

open class KBRouter<T: KBRoute> {
    
    public private(set) var route: KBRoute
    public private(set) var domains: [String]
    
    public init(_ route: KBRoute, domains: [String] = []) {
        self.route = route
        self.domains = domains
    }
    
}
