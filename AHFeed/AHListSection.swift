//
//  AHListSection.swift
//  AHFeed
//
//  Created by Andreas Hörberg on 2019-03-29.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class AHListSection: UIView, UIScrollViewDelegate {
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = true
        scroll.isPagingEnabled = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        return scroll
    }()

    let header: UILabel = {
        let header = UILabel()
        header.font = UIFont.boldSystemFont(ofSize: 23)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.layoutIfNeeded()
        return header
    }()

    var sectionHeight = UIScreen.main.bounds.width/1.5
    var itemWidth = UIScreen.main.bounds.width/1.5

    private let headerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func addArrangedSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isAccessibilityElement = true
        stackView.addArrangedSubview(view)
        view.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
    }

    private func setup() {
        heightAnchor.constraint(equalToConstant: sectionHeight).isActive = true

        scrollView.addSubview(stackView)
        headerContainer.addSubview(header)
        addSubview(headerContainer)
        addSubview(scrollView)

        headerContainer.addConstraints([
            header.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            header.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: 16),
            header.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 16),
            header.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
            ])

        addConstraints([
            headerContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerContainer.topAnchor.constraint(equalTo: topAnchor)
            ])

        addConstraints([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: headerContainer.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        let stackWidthAnchor = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        stackWidthAnchor.priority = UILayoutPriority(999)

        let stackHeightAnchor = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        stackHeightAnchor.priority = UILayoutPriority(1000)

        scrollView.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackWidthAnchor,
            stackHeightAnchor
            ])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let transform = CGAffineTransform(translationX: offset, y: 0)
        let negativeTransform = CGAffineTransform(translationX: -offset, y: 0)
        stackView.transform = transform

        stackView.arrangedSubviews.enumerated().forEach { view in
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
