//
//  ZoomTransitionDelegate.swift
//  The Movie App
//
//  Created by Raul Marques de Oliveira on 14/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

protocol ZoomingViewController {
    func zoomingImageView(for transition: ZoomTransitionDelegate) -> UIImageView?
    func zoomingBackgroudView(for transition: ZoomTransitionDelegate) -> UIView?
}
enum TransitionState {
    case initial
    case final
}

class ZoomTransitionDelegate: NSObject {
    
    var trasitionDuration = 0.5
    var operation: UINavigationController.Operation = .none
    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7)
    
    typealias ZoomingViews = (otherViews: UIView, imageView: UIView)
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            
            var frame = containerView.convert(viewsInBackground.imageView.bounds, to: viewsInBackground.imageView)
            frame.origin.x = -frame.origin.x
            frame.origin.y = -frame.origin.y
            snapshotViews.imageView.frame = frame
            snapshotViews.imageView.cornerRadius = 40
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            
            var frame = containerView.convert(viewsInForeground.imageView.bounds, to: viewsInForeground.imageView)
            frame.origin.x = -frame.origin.x
            frame.origin.y = -frame.origin.y
            snapshotViews.imageView.frame = frame
            snapshotViews.imageView.cornerRadius = 60
        }
    }
}

extension ZoomTransitionDelegate: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingViewController && toVC is ZoomingViewController {
            self.operation = operation
            return self
        } else {
            return nil
        }
    }
}

extension ZoomTransitionDelegate: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return trasitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        let maybeBackgroundImageView = (backgroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        let maybeForegroundImageView = (foregroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        
        assert(maybeBackgroundImageView != nil, "Cannot find imageview in backgroundVC")
        assert(maybeForegroundImageView != nil, "Cannot find imageview in foregroundVC")
        
        let backgroundImageView =  maybeBackgroundImageView!
        let foregroundImageView =  maybeForegroundImageView!
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true

       
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
//        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.alpha = 0//.backgroundColor = .clear
        containerView.backgroundColor = .white
        
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(imageViewSnapshot)
        
//        imageViewSnapshot.isHidden = true
        var preTrasitionState = TransitionState.initial
        var postTrasitionState = TransitionState.final
        
        if operation == .pop {
            preTrasitionState = TransitionState.final
            postTrasitionState = TransitionState.initial
        }
        
        configureViews(for: preTrasitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView, backgroundImageView), viewsInForeground: (foregroundImageView, foregroundImageView), snapshotViews: (imageViewSnapshot,imageViewSnapshot))
        
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            
            self.configureViews(for: postTrasitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundViewController.view, backgroundImageView), viewsInForeground: (foregroundViewController.view, foregroundImageView), snapshotViews: (imageViewSnapshot,imageViewSnapshot))
            
        }) { (finished) in
            
            backgroundViewController.view.transform = CGAffineTransform.identity
            imageViewSnapshot.removeFromSuperview()
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            foregroundViewController.view.alpha = 1//.backgroundColor = foregroundViewBackgroundColor

            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
}
