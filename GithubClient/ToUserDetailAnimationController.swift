//
//  ToUserDetailAnimationController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/21/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class ToUserDetailAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
 
        //get references toVC, fromVC, and containerView
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as SearchUserViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserDetailViewController
        let containerView = transitionContext.containerView()
        
        //find selected cell, make snapshot
        let selectedIndexPath = fromVC.collectionView.indexPathsForSelectedItems().first as NSIndexPath
        let cell = fromVC.collectionView.cellForItemAtIndexPath(selectedIndexPath) as UserCell
        let cellImageSnapshot = cell.userImage.snapshotViewAfterScreenUpdates(false)
        cell.userImage.hidden = true
        cellImageSnapshot.frame = containerView.convertRect(cell.userImage.frame, fromView: cell.userImage.superview)
        
        //init toVC but set to hidden
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.view.alpha = 0
        toVC.userImage.hidden = true
        
        //add views to containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(cellImageSnapshot)
        
        //trigger toVC's autolayout to allow reference
        toVC.view.setNeedsLayout() // triggers update to autolayout
        toVC.view.layoutIfNeeded() // applies autolayout
        
        
        //animation
        let duration = self.transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: { () -> Void in
            //animate changing of userImage snapshotFrame -> toVC.userImageFrame
            toVC.view.alpha = 1.0 //show toVC
            cellImageSnapshot.frame = containerView.convertRect(toVC.userImage.frame, fromView: toVC.view)
            
        }) { (finished) -> Void in
            //clean up
            toVC.userImage.hidden = false //show userImage in end view
            cell.userImage.hidden = false //show cell's userImage
            cellImageSnapshot.removeFromSuperview() // snapshot no longer needed
            transitionContext.completeTransition(true) // internal cleanup after animation
        }
        
    }
    
    
}
