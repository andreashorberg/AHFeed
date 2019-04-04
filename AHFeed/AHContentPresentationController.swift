//
//  AHContentPresentationController.swift
//  AHFeed
//
//  Created by Andreas Hörberg on 2019-02-19.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

final class AHContentPresentationController: UIPresentationController {
    var contentFrame: CGRect?

    override var frameOfPresentedViewInContainerView: CGRect {
        return contentFrame ?? UIScreen.main.bounds
    }

    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        let view = presentingViewController.view
        view?.frame = containerView?.bounds ?? .zero
        containerView?.insertSubview(view!, at: 0)
    }
}
