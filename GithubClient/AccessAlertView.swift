//
//  AccessAlertView.swift
//  GithubClient
//
//  Created by Pho Diep on 1/22/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class AccessAlertView: UIView {

    
    @IBAction func OKbutton(sender: AnyObject) {
        
        self.hidden = true
        NetworkController.sharedInstance.requestAccessToken()
    }
    
}