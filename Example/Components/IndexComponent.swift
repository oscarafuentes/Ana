//
//  IndexComponent.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Kerabyte

public class IndexComponent: KBComponent {
    
    public override func generateTemplate() -> UIResponder {
        return IndexTemplate()
    }
    
    public func onRouteAbout() {
        Kerabyte.dispatch(URL(string: "/about")!)
    }
    
    public func onRoutePrivacyPolicy() {
        Kerabyte.dispatch(URL(string: "/privacy-policy")!)
    }
    
    public func onRouteTermsOfUse() {
        Kerabyte.dispatch(URL(string: "/terms-of-use")!)
    }
    
}
