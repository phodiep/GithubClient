//
//  ProfileViewController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/23/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User!
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var blogLabel: UILabel!
    @IBOutlet var hireableLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet var publicRepoLabel: UILabel!
    @IBOutlet var publicGistLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    @IBOutlet var followingLabel: UILabel!
    @IBOutlet var totalPrivateRepoLabel: UILabel!
    @IBOutlet var ownedRepoLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var htmlURLLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkController.sharedInstance.fetchUserProfile({ (user, error) -> () in
            if error == nil && user != nil {
                self.user = user
                
                if self.user.avatar == nil {
                    NetworkController.sharedInstance.fetchImage(self.user.avatarURL, completionHandler: { (image) -> () in
                        self.user.updateAvatarImage(image!)
                        self.avatarImage.image = image
                    })
                } else {
                    self.avatarImage.image = self.user.avatar
                }
                
                self.nameLabel.text = self.user.name
//                self.companyLabel.text = self.user.company
                self.emailLabel.text = self.user.email
                self.blogLabel.text = "Blog: \(self.user.blogURL!)"
                self.hireableLabel.text = "Hireable: \(self.user.hireable!)"
                self.locationLabel.text = "Location: \(self.user.location!)"
                self.bioLabel.text = self.user.bio
                self.publicRepoLabel.text = "Public Repos: \(self.user.publicRepos!)"
                self.publicGistLabel.text = "Public Gists: \(self.user.publicGists!)"
                self.followersLabel.text = "Followers: \(self.user.followers!)"
                self.followingLabel.text = "Following: \(self.user.following!)"
                self.totalPrivateRepoLabel.text = "Total Private Repos: \(self.user.totalPrivateRepos!)"
                self.ownedRepoLabel.text = "Owned Private Repos: \(self.user.ownedPrivateRepos!)"
                self.idLabel.text = self.user.ID
                self.loginLabel.text = self.user.login
                self.htmlURLLabel.text = self.user.htmlURL
                
            }
        })
        
        

    }


}
