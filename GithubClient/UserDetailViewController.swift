//
//  UserDetailViewController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var htmlURLLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var idLabel: UILabel!

    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginLabel.text = user.login
        self.userImage.image = user.avatar
        self.idLabel.text = user.ID
        self.htmlURLLabel.text = user.htmlURL

        // Do any additional setup after loading the view.
    }


}
