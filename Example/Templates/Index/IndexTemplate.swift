//
//  IndexTemplate.swift
//  Kerabyte
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation
import UIKit

public class IndexTemplate: UIViewController {
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var termsOfUseButton: UIButton!
    
    @IBAction func onTapPublic(_ sender: UIButton) {
        guard let responder = self.component as? IndexComponent else {
            return
        }
        
        switch sender {
        case self.aboutButton:
            responder.onRouteAbout()
            break
        case self.privacyPolicyButton:
            responder.onRoutePrivacyPolicy()
            break
        case self.termsOfUseButton:
            responder.onRouteTermsOfUse()
            break
        default:
            break
        }
        
        
    }
    
}
