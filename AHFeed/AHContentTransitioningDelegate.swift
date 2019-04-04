//
//  AHContentTransitioningDelegate.swift
//  AHFeed
//
//  Created by Andreas Hörberg on 2019-02-19.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class AHContentTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    var contentFrame: CGRect?
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = AHContentPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.contentFrame = contentFrame
        return presentationController
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AHContentPresentationAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AHContentDismissionAnimator(frame: contentFrame)
    }
}
