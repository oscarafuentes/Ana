//
//  TermsOfUseComponent.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import Ana

public class TermsOfUseComponent: AComponent {
    
    public override func generateTemplate() -> UIResponder {
        return TermsOfUseTemplate()
    }
    
}
