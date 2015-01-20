//
//  NetworkController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/19/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import Foundation

class NetworkController {
    
    var urlSession: NSURLSession
    
    init() {
        let ephemeralConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        self.urlSession = NSURLSession(configuration: ephemeralConfig)
    }
    
    func fetchRepositoriesForSearchTerm(searchTerm: String, callback: ([Repository]?, String?) -> () ) {
//        let url = NSURL( "https://api.github.com/search/repositories?q=\(searchTerm)")
        
        let url = NSURL(string: "http://127.0.0.1:3000") //Temp Url
        
        let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (jsonData, response, error) -> Void in
            let urlResponse = response as NSHTTPURLResponse
            
            switch urlResponse.statusCode {
            case 200...299:
                var repos = [Repository]()
                let jsonDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as [String : AnyObject]
                let repoList = jsonDictionary["items"] as [AnyObject]

                for repoData in repoList {
                    let data = repoData as [String: AnyObject]
                    let repo = Repository(jsonDictionary: data)
                    repos.append(repo)
                }
                callback(repos, nil)
                
            case 300...599:
                callback(nil, "\(urlResponse.statusCode)error ... \(error)")
            default:
                break
            }
            
            })
    dataTask.resume()
    }
    
    
    
}