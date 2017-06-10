//
//  AboutRoute.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Kerabyte

public class AboutRoute: KBRoute {
    
    public init() {
        super.init("/about")
    }
    
    public override func generateComponent() -> KBComponent {
        return AboutComponent()
    }
    
}
