//
//  IndexComponent.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Ana

public class IndexComponent: AComponent {
    
    public override func generateTemplate() -> UIResponder {
        return IndexTemplate()
    }
    
    public func onRouteAbout() {
        Ana.dispatch(URL(string: "/about")!)
    }
    
    public func onRoutePrivacyPolicy() {
        Ana.dispatch(URL(string: "/privacy-policy")!)
    }
    
    public func onRouteTermsOfUse() {
        Ana.dispatch(URL(string: "/terms-of-use")!)
    }
    
}
