//
//  TermsOfUseRoute.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Kerabyte

public class TermsOfUseRoute: KBRoute {
    
    public init() {
        super.init("/terms-of-use")
    }
    
    public override func generateComponent() -> KBComponent {
        return TermsOfUseComponent()
    }
    
}
