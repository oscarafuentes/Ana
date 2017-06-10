//
//  IndexRoute.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Ana

public class IndexRoute: ARoute {
    
    public init() {
        super.init(
            nil,
            match: false,
            subRoutes: [
                AboutRoute(),
                PrivacyPolicyRoute(),
                TermsOfUseRoute()
            ])
    }
    
    public override func generateComponent() -> AComponent {
        return IndexComponent()
    }
    
}
