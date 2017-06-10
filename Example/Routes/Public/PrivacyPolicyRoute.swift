//
//  PrivacyPolicyRoute.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Kerabyte

public class PrivacyPolicyRoute: KBRoute {
    
    public init() {
        super.init("/privacy-policy")
    }
    
    public override func generateComponent() -> KBComponent {
        return PrivacyPolicyComponent()
    }
    
}
