//
//  PrivacyPolicyComponent.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Kerabyte

public class PrivacyPolicyComponent: KBComponent {
    
    public override func generateTemplate() -> UIResponder {
        return PrivacyPolicyTemplate()
    }
    
}
