//
//  NetworkController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/19/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class NetworkController {
    
    var urlSession: NSURLSession
    var imageQueue = NSOperationQueue()
    
    let accessTokenDefaultsKey = "accessToken"
    var accessToken: String?
    

    //Singleton
    class var sharedInstance : NetworkController {
        struct Static {
            static let instance: NetworkController = NetworkController()
        }
        return Static.instance
    }
    
    
    init() {
        let ephemeralConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        self.urlSession = NSURLSession(configuration: ephemeralConfig)
        
        if let defaultAccessToken = NSUserDefaults.standardUserDefaults().objectForKey(self.accessTokenDefaultsKey) as? String {
            self.accessToken = defaultAccessToken
        } else {
            requestAccessToken()
        }
    }
    
    func requestAccessToken() {
        let url = "https://github.com/login/oauth/authorize?client_id=\(self.clientID)&scope=user,repo"
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    func handleCallbackURL(url: NSURL) {
        let code = url.query
        
        // query as part of url string
        let oauthURL = "https://github.com/login/oauth/access_token?\(code!)&client_id=\(self.clientID)&client_secret=\(self.clientSecret)"
        let postRequest = NSMutableURLRequest(URL: NSURL(string: oauthURL)!)
        postRequest.HTTPMethod = "POST"
        
        let dataTask = self.urlSession.dataTaskWithRequest(postRequest, completionHandler: { (data, URLResponse, error) -> Void in
            if error == nil {
                if let httpResponse = URLResponse as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        //decode data to NSString
                        let tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
                        //separate string by "&" ... saving element before 1st "&"
                        let accessTokenComponent = tokenResponse?.componentsSeparatedByString("&").first as String
                        //separate string by "=" ... saving element after "="
                        let accessToken = accessTokenComponent.componentsSeparatedByString("=").last
                        
                        self.accessToken = accessToken
                        
                        //save accessToken as default for user, and sync
                        NSUserDefaults.standardUserDefaults().setObject(accessToken!, forKey: self.accessTokenDefaultsKey)
                        NSUserDefaults.standardUserDefaults().synchronize()
                    default:
                        break
                    }
                }
            }
        })
        dataTask.resume()
        
    }
    
    
    func fetchRepositoriesForSearchTerm(searchTerm: String, callback: ([Repository]?, String?) -> () ) {
        let url = NSURL(string: "https://api.github.com/search/repositories?q=\(searchTerm)")
        
//        let url = NSURL(string: "http://127.0.0.1:3000") //Temp Url
        
        //sign request w/ authorization token
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("token \(self.accessToken!)", forHTTPHeaderField: "Authorization")
        
        
        let dataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: { (jsonData, response, error) -> Void in
            if error == nil {
                if let urlResponse = response as? NSHTTPURLResponse {
                    var repos = [Repository]()
                    var errorStr: String?
                    
                    switch urlResponse.statusCode {
                    case 200...299:
                        
                        let jsonDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as [String : AnyObject]
                        let repoList = jsonDictionary["items"] as [AnyObject]
                        
                        for repoData in repoList {
                            let data = repoData as [String: AnyObject]
                            let repo = Repository(jsonDictionary: data)
                            repos.append(repo)
                        }
                    case 300...599:
                        errorStr = "\(urlResponse.statusCode)error ... \(error)"
                    default:
                        errorStr = "default"
                    }
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        callback(repos, errorStr)
                    })
                }
            }
        })
        dataTask.resume()
    }
    
    func fetchRepositoriesForUsers(searchUser: String, callback: ([User]?, String?) -> () ) {
        let url = NSURL(string: "https://api.github.com/search/users?q=\(searchUser)" )

        let dataTask = self.urlSession.dataTaskWithURL(url!, completionHandler: { (jsonData, response, error) -> Void in
            let urlResponse = response as NSHTTPURLResponse
            var users = [User]()
            var errorStr: String?

            switch urlResponse.statusCode {
            case 200...299:
                let jsonDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as [String : AnyObject]
                let userList = jsonDictionary["items"] as [AnyObject]
                for userData in userList {
                    let data = userData as [String: AnyObject]
                    let user = User(userDictionary: data)
                    users.append(user)
                }
            case 300...599:
                errorStr = "\(urlResponse.statusCode)error ... \(error)"
            default:
                errorStr = "default"
            }
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                callback(users, errorStr)
            })
        })
        dataTask.resume()
    }
    
    
    func fetchImage(imageURL: String, completionHandler: (UIImage?) -> () ) {
        self.imageQueue.addOperationWithBlock({ () -> Void in
            if let imageData = NSData(contentsOfURL: NSURL(string: imageURL)!) {
                let image = UIImage(data: imageData)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completionHandler(image)
                })
            }
        })
    }

    
    
}