//
//  IndexRoute.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Kerabyte

public class IndexRoute: KBRoute {
    
    public override func generateComponent() -> KBComponent {
        return IndexComponent()
    }
    
}
