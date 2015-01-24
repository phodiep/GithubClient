//
//  SearchUserViewController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UINavigationControllerDelegate {

    var users = [User]()
    
    var transitionFrame: CGRect?
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.searchBar.delegate = self
        self.navigationController?.delegate = self
        

    }
    
    
    //MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell
        cell.userLabel.text = self.users[indexPath.row].login
        
        if self.users[indexPath.row].avatar == nil {
            NetworkController.sharedInstance.fetchImage(self.users[indexPath.row].avatarURL, completionHandler: { (image) -> () in
                cell.userImage.image = self.users[indexPath.row].avatar
                self.users[indexPath.row].updateAvatarImage(image!)
                self.collectionView.reloadItemsAtIndexPaths([indexPath])
            })
        } else {
            cell.userImage.image = self.users[indexPath.row].avatar
        }

        return cell
    }
        
    //MARK: UINavigationControllerDelegate
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if toVC is UserDetailViewController {
            return ToUserDetailAnimationController()
        }

        return nil //default animation
    }
    
    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "SEGUE_USER" {
            let indexPathSelected = self.collectionView.indexPathsForSelectedItems()[0].row
            let userSelected = self.users[indexPathSelected]
            let userVC = segue.destinationViewController as UserDetailViewController
            userVC.user = userSelected

        }
    }
    
    //MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        NetworkController.sharedInstance.fetchRepositoriesForUsers(searchBar.text, callback: { (users, error) -> () in
            if error == nil && users != nil {
                self.users = users!
                self.collectionView.reloadData()
            }
        })
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return text.validateForRegex()
    }

    

}
