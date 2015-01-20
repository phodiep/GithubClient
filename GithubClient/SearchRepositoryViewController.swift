//
//  SearchRepositoryViewController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/19/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var networkController: NetworkController!
    var repositories: [Repository]?
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkController = NetworkController()
        self.tableView.dataSource = self
        self.searchBar.delegate = self

    }

    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as UITableViewCell
        
        return cell
    }

    
    //MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder() //hides keyboard

        self.networkController.fetchRepositoriesForSearchTerm(searchBar.text, callback: { (repos, error) -> () in
            if error == nil && repos != nil {
                self.repositories = repos!
                self.tableView.reloadData()
            }
        })
    }


}
