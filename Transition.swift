//
//  Help.swift
//  vistaBAC
//
//  Created by Apps001 on 13/04/18.
//  Copyright © 2018 appsdeveloper. All rights reserved.
//

import Foundation
import UIKit

enum PresentationStyle {
    case Right
    case Left
}

class TransitionPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting = true
    var presentatioStyle = PresentationStyle.Right
    init(ispresenting : Bool,style:PresentationStyle) {
        super.init()
        self.isPresenting = ispresenting
        self.presentatioStyle = style
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        if(self.isPresenting == true) {
            switch presentatioStyle{
            case .Right:
                let offScreenLeft = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
                toViewController!.view.transform = offScreenLeft
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    toViewController!.view.transform = .identity
                    fromViewController?.view.transform = CGAffineTransform.init(translationX: containerView.frame.width, y: 0)
                    containerView.addSubview(toViewController!.view)
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(completed)
                })
                break
            case .Left:
                let offScreenLeft = CGAffineTransform(translationX: containerView.frame.width, y: 0)
                toViewController!.view.transform = offScreenLeft
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    toViewController!.view.transform = .identity
                    fromViewController?.view.transform = CGAffineTransform.init(translationX: -containerView.frame.width, y: 0)
                    containerView.addSubview(toViewController!.view)
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(completed)
                })
                break
            }
        }
        else {
            switch presentatioStyle {
            case .Right:
                let offScreenLeft = CGAffineTransform(translationX: containerView.frame.width, y: 0)
                toViewController!.view.transform = offScreenLeft
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    fromViewController!.view.transform = CGAffineTransform.init(translationX: -containerView.frame.width, y: 0)
                    toViewController?.view.transform = .identity
                }, completion: { (completed) -> Void in
                    fromViewController?.view.removeFromSuperview()
                    transitionContext.completeTransition(completed)
                })
                break
            case .Left:
                let offScreenLeft = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
                toViewController!.view.transform = offScreenLeft
                fromViewController?.view.transform = .identity
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    fromViewController!.view.transform = CGAffineTransform.init(translationX: containerView.frame.width, y: 0)
                    toViewController?.view.transform = .identity
                }, completion: { (completed) -> Void in
                    fromViewController?.view.removeFromSuperview()
                    transitionContext.completeTransition(completed)
                })
                break
            }
        }
    }
}

