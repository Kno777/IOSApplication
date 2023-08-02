//
//  CustomAnimationTransitionDismisser.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 02.08.23.
//

import UIKit

class CustomAnimationTransitionDismisser: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // my custom transiation animation code
        
        let conatinerView = transitionContext.containerView
        
        // fromView - camera
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        // toView - home
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        conatinerView.addSubview(toView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            // animation
            
            fromView.frame = CGRect(x: -fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height)
            
            toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
            
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
}
