//
//  Repository.swift
//  GithubClient
//
//  Created by Pho Diep on 1/19/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import Foundation

struct Repository {
    
    var description: String
    var forksCount: String
    var fullName: String
    var htmlURL: String
    var ID: String
//    var language: String
//    var masterBranch: String
//    var name: String
//    var openIssuesCount: String
//    var apiURL: String
    
    var user: User
    
    init(jsonDictionary: [String: AnyObject]) {
        
        self.description = jsonDictionary["description"] as String

        let forksCount_int = jsonDictionary["forks_count"] as Int
        self.forksCount = "\(forksCount_int)"
        
        self.fullName = jsonDictionary["full_name"] as String
        self.htmlURL = jsonDictionary["html_url"] as String
        
        let id_int = jsonDictionary["id"] as Int
        self.ID = "\(id_int)"
        
//        self.language = jsonDictionary["language"] as String
//        self.masterBranch = jsonDictionary["master_branch"] as String
//        self.name = jsonDictionary["name"] as String
        
//        let openIssuesCount_Int = jsonDictionary["open_issues_count"] as Int
//        self.openIssuesCount = "\(openIssuesCount_Int)"
//        
//        self.apiURL = jsonDictionary["url"] as String
        
        let ownerDictionary = jsonDictionary["owner"] as [String: AnyObject]
        self.user = User(userDictionary: ownerDictionary)
        

        
    }
}