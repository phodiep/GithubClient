//
//  Repository.swift
//  GithubClient
//
//  Created by Pho Diep on 1/19/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import Foundation

struct Repository {
    var user: User
    var description: String
    var fullName: String
    var htmlURL: String
    var ID: String
    var language: String

    
    init(jsonDictionary: [String: AnyObject]) {

        let ownerDictionary = jsonDictionary["owner"] as [String: AnyObject]
        self.user = User(userDictionary: ownerDictionary)

        self.description = jsonDictionary["description"] as String
        
        self.fullName = jsonDictionary["full_name"] as String
        self.htmlURL = jsonDictionary["html_url"] as String
        
        let id_int = jsonDictionary["id"] as Int
        self.ID = "\(id_int)"
        
        self.language = jsonDictionary["language"] as String
        
    }
}