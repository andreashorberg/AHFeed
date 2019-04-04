//
//  ViewController.swift
//  AHFeed
//
//  Created by Andreas Hörberg on 2019-02-19.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        verticalStack.addArrangedSubview(editorsChoiceSection)
        addVerticalItems()
        verticalStack.addArrangedSubview(readMoreSection)
        verticalScrollView.delegate = self
        verticalHeader.text = "Explore"
    }
    
    lazy var editorsChoiceSection: AHListSection = {
        let section = AHListSection()
        section.header.text = "Editors choice"
        for _ in 0...4 {
            let view = AHCardView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(expandCard(_:)))
            tap.delegate = self
            view.addGestureRecognizer(tap)
            section.addArrangedSubview(view)
        }
        return section
    }()

    lazy var readMoreSection: AHListSection = {
        let section = AHListSection()
        section.header.text = "Read more"
        for _ in 0...4 {
            let view = AHCardView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(expandCard(_:)))
            tap.delegate = self
            view.addGestureRecognizer(tap)
            section.addArrangedSubview(view)
        }
        return section
    }()
    
    let verticalHeader: UILabel = {
        let header = UILabel()
        header.font = UIFont.boldSystemFont(ofSize: 23)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        header.layoutIfNeeded()
        return header
    }()
    
    private let headerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    @IBOutlet weak var verticalScrollView: UIScrollView!
    @IBOutlet weak var verticalStack: UIStackView!
    let customTransitioningDelegate = AHContentTransitioningDelegate()
    var selectedView: UIView?

    func addVerticalItems() {
        headerContainer.addSubview(verticalHeader)
        verticalStack.addArrangedSubview(headerContainer)
        headerContainer.addConstraints([
            verticalHeader.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            verticalHeader.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: 16),
            verticalHeader.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 16),
            verticalHeader.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 0)
            ])

        for _ in 0...12 {
            let view = AHCardView()
            view.translatesAutoresizingMaskIntoConstraints = false
            verticalStack.addArrangedSubview(view)
            view.isAccessibilityElement = true
            let coinFlip = Bool.random()
            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: coinFlip ? 0.75 : 0.4).isActive = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(expandCard(_:)))
            tap.delegate = self
            view.addGestureRecognizer(tap)
        }
    }
    
    @objc func expandCard(_ sender: UITapGestureRecognizer) {
        let origin = sender.view
        selectedView = origin
        if let originFrame = origin?.frame {
            let frameInWindow = origin!.convert(CGPoint(x: 0, y: 0), to: view)
            let convertedFrame = CGRect(x: frameInWindow.x, y: frameInWindow.y, width: originFrame.width, height: originFrame.height)

            customTransitioningDelegate.contentFrame = convertedFrame

            let viewController = AHContentView()
            viewController.view.backgroundColor = origin?.backgroundColor
            viewController.transitioningDelegate = customTransitioningDelegate
            viewController.modalPresentationStyle = .custom

            present(viewController, animated: true, completion: nil)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let negativeTransform = CGAffineTransform(translationX: 0, y: -offset)
        verticalStack.transform = CGAffineTransform(translationX: 0, y: offset)

        verticalStack.arrangedSubviews.enumerated().forEach { view in
            let delay = Double(view.offset) * 0.01
            let duration = 1.0 - delay
            view.element.layoutIfNeeded()
            UIView.animate(withDuration: duration,
                           delay: delay,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0.7,
                           options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
                           animations: {
                            view.element.transform = negativeTransform
                            view.element.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
