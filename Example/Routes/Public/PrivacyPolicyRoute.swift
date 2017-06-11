//
//  PrivacyPolicyRoute.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Ana

public class PrivacyPolicyRoute: ARoute {
    
    public init() {
        super.init("/privacy-policy")
    }
    
    public override func generateComponent() -> AComponent {
        return PrivacyPolicyComponent()
    }
    
}
