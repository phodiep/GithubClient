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
        self.view.addSubview(self.webView)
        
        self.webView.setTranslatesAutoresizingMaskIntoConstraints(false)

        let views = ["webView": self.webView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[webView]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[webView]|", options: nil, metrics: nil, views: views))
        
        let request = NSURLRequest(URL: NSURL(string: self.url)!)
        self.webView.loadRequest(request)
        
    }
}
