//
//  FromUserDetailAnimationController.swift
//  GithubClient
//
//  Created by Pho Diep on 1/21/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class FromUserDetailAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //grab references to both view controllers
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserDetailViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as SearchUserViewController
        let containerView = transitionContext.containerView()
        
        //determine previously selected cell frame and grab snapshot
        let selectedCellFrame = toVC.transitionFrame
        let snapshotOfImage = fromVC.userImage.snapshotViewAfterScreenUpdates(false)
        fromVC.userImage.hidden = true
        snapshotOfImage.frame = fromVC.userImage.frame
        
        //make toVC start on screen, but invisible
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.view.alpha = 0
        //?? hide selected userImage?
        
        //trigger autolayout on toVC
        toVC.view.setNeedsLayout()
        toVC.view.layoutIfNeeded()
        
        //animation
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            //animation
            toVC.view.alpha = 1.0 //show toVC
            snapshotOfImage.frame = toVC.transitionFrame!
            
        }) { (finished) -> Void in
            //clean up
            
            snapshotOfImage.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        
        
        
    }
    
    
    
}
