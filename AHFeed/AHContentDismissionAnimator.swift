//
//  AHContentDismissionAnimator.swift
//  AHFeed
//
//  Created by Andreas Hörberg on 2019-02-19.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class AHContentDismissionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var contentFrame: CGRect?

    init(frame: CGRect? = nil) {
        super.init()
        contentFrame = frame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.65
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)
        containerView.layoutIfNeeded()

        fromViewController?.view.constraints.forEach {
            $0.isActive = false
        }
        
        guard let newFrame = contentFrame else {
            transitionContext.completeTransition(true)
            return
        }
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            fromViewController?.view.frame = newFrame
            containerView.layoutIfNeeded()
        }, completion: { finished in
            transitionContext.completeTransition(finished)
            if let window = UIApplication.shared.keyWindow, let viewController = window.rootViewController {
                window.addSubview(viewController.view)
            }
        })
    }
}
