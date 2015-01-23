//
//  User.swift
//  GithubClient
//
//  Created by Pho Diep on 1/19/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit


class User {
    
    var avatarURL: String
    var avatar: UIImage?
    var ID: String
    var login: String
    var htmlURL: String
    
    var name: String?
    var company: String?
    var email: String?
    var blogURL: String?
    var hireable: Bool?
    var location: String?
    var bio: String?
    var publicRepos: Int?
    var publicGists: Int?
    var followers: Int?
    var following: Int?
    var totalPrivateRepos: Int?
    var ownedPrivateRepos: Int?
    
    init(userDictionary: [String: AnyObject]) {
        self.avatarURL = userDictionary["avatar_url"] as String
        
        let id_int = userDictionary["id"] as Int
        self.ID = "\(id_int)"
        
        self.login = userDictionary["login"] as String
        self.htmlURL = userDictionary["html_url"] as String
    }
    
    func updateAvatarImage(image: UIImage) {
        self.avatar = image
    }
    
    func updateFullProfile(userDictionary: [String: AnyObject]) {
        self.name = userDictionary["name"] as? String
        self.company = userDictionary["company"] as? String

        self.email = userDictionary["email"] as? String
        self.blogURL = userDictionary["blog"] as? String
        self.hireable = userDictionary["hireable"] as? Bool
        self.location = userDictionary["location"] as? String
        self.bio = userDictionary["bio"] as? String

        self.publicRepos = userDictionary["public_repos"] as? Int
        self.publicGists = userDictionary["public_gists"] as? Int
        self.followers = userDictionary["followers"] as? Int
        self.following = userDictionary["following"] as? Int

        self.totalPrivateRepos = userDictionary["total_private_repos"] as? Int
        self.ownedPrivateRepos = userDictionary["owned_private_repos"] as? Int

    }
}