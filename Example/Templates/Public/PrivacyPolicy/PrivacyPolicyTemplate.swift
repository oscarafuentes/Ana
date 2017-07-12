//
//  PrivacyPolicyTemplate.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import UIKit
import Ana

public class PrivacyPolicyTemplate: UIViewController {
    
    @IBAction func onTapBack() {
        guard let responder = self.component as? PrivacyPolicyComponent else {
            return
        }
        
        responder.onRouteBack()
    }
    
    public override func transitionStyle() -> Int {
        return AViewControllerTransitionStyle.presentation
    }
    
}
