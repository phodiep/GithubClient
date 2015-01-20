//
//  SearchUserViewController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    var networkController: NetworkController!
    var users: [User]?
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkController = NetworkController.sharedInstance
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.searchBar.delegate = self
        

    }

    //MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let userCount = users?.count {
            return userCount
        } else {
            return 0
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell
        cell.userLabel.text = self.users![indexPath.row].login
        self.networkController.fetchImage(self.users![indexPath.row].avatarURL, completionHandler: { (image) -> () in
            cell.userImage.image = image
        })
        return cell
    }
    
    //MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.networkController.fetchRepositoriesForUsers(searchBar.text, callback: { (users, error) -> () in
            if error == nil && users != nil {
                self.users = users!
                self.collectionView.reloadData()
            }
        })
        searchBar.resignFirstResponder()
    }

    

}
