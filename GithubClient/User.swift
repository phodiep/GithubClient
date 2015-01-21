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
//    var score: String
    var htmlURL: String
    
    init(userDictionary: [String: AnyObject]) {
        self.avatarURL = userDictionary["avatar_url"] as String
        
        let id_int = userDictionary["id"] as Int
        self.ID = "\(id_int)"
        
//        let score_float = userDictionary["score"] as Float
//        self.score = "\(score_float)"
        
        self.login = userDictionary["login"] as String
        self.htmlURL = userDictionary["html_url"] as String
    }
    
    func updateAvatarImage(image: UIImage) {
        self.avatar = image
    }
}