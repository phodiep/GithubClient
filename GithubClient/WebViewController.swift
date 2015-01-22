//
//  WebViewController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/22/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //init webViewFrame
        self.webView.frame = self.view.frame
        self.view.backgroundColor = UIColor.redColor()
        
        self.webView.setTranslatesAutoresizingMaskIntoConstraints(false)

        let views = ["webView": self.webView]
        
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
//            "H:|[webView]|", options: nil, metrics: nil, views: views))
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
//            "V:|[webView]|", options: nil, metrics: nil, views: views))
        
        self.view.addSubview(self.webView)
        
        let request = NSURLRequest(URL: NSURL(string: self.url)!)
        self.webView.loadRequest(request)
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
