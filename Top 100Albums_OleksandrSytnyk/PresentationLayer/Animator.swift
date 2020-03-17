//
//  Animator.swift
//  Top 100Albums_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/13/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import  UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var popStyle: Bool = false
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if popStyle {
            
            animatePop(using: transitionContext)
            return
        }
        
        let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let f = transitionContext.finalFrame(for: toController)
        
        let fOff = f.offsetBy(dx: f.width, dy: 355)
        toController.view.frame = fOff
        
        transitionContext.containerView.insertSubview(toController.view, aboveSubview: fromController.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toController.view.frame = f
        }, completion: {_ in
            transitionContext.completeTransition(true)
        })
    }
    
    func animatePop(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let tz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let f = transitionContext.initialFrame(for: fz)
        let fOffPop = f.offsetBy(dx: f.width, dy: 100)
        
        transitionContext.containerView.insertSubview(tz.view, belowSubview: fz.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fz.view.frame = fOffPop
        }, completion: {_ in
            transitionContext.completeTransition(true)
        })
    }
}

