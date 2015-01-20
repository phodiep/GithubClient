//
//  User.swift
//  GithubClient
//
//  Created by Pho Diep on 1/19/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import Foundation


struct User {
    
    var avatarURL: String
//    var gravatarID: String
//    var ID: String
    var login: String
//    var receivedEventsURL: String
//    var URL: String
    
    init(userDictionary: [String: AnyObject]) {
        self.avatarURL = userDictionary["avatar_url"] as String
//        self.gravatarID = userDictionary["gravatar_id"] as String
//        
//        let id_int = userDictionary["id"] as Int
//        self.ID = "\(id_int)"
        
        self.login = userDictionary["login"] as String
//        self.receivedEventsURL = userDictionary["received_events_url"] as String
//        self.URL = userDictionary["url"] as String
    }
}