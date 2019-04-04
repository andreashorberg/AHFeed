//
//  AHContentPresentationAnimator.swift
//  AHFeed
//
//  Created by Andreas Hörberg on 2019-02-19.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class AHContentPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var contentFrame: CGRect?

    init(frame: CGRect? = nil) {
        super.init()
        contentFrame = frame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.65
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        let animatonDuration = transitionDuration(using: transitionContext)

        containerView.layoutIfNeeded()
        containerView.addSubview(toViewController!.view)

        UIView.animate(withDuration: animatonDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            toViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addConstraints([
                (toViewController?.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor))!,
                (toViewController?.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor))!,
                (toViewController?.view.topAnchor.constraint(equalTo: containerView.topAnchor))!,
                (toViewController?.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor))!
                ])
            containerView.layoutIfNeeded()
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}

