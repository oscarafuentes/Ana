//
//  TermsOfUseRoute.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Ana

public class TermsOfUseRoute: ARoute {
    
    public init() {
        super.init("/terms-of-use")
    }
    
    public override func generateComponent() -> AComponent {
        return TermsOfUseComponent()
    }
    
}
