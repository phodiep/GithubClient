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
    
    var repositories: [Repository]?
    
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.searchBar.delegate = self

    }

    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repoCount = self.repositories?.count {
            return self.repositories!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as RepositoryCell
        
        cell.userLabel.text = self.repositories![indexPath.row].user.login
        cell.repoNameLabel.text = self.repositories![indexPath.row].fullName
        
        return cell
    }

    
    //MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {

        NetworkController.sharedInstance.fetchRepositoriesForSearchTerm(searchBar.text, callback: { (repos, error) -> () in
            if error == nil && repos != nil {
                self.repositories = repos!
                self.tableView.reloadData()
            }
        })
        searchBar.resignFirstResponder() //hides keyboard
    }

    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return text.validateForRegex()
    }


}
