//
//  AHContentView.swift
//  AHFeed
//
//  Created by Andreas Hörberg on 2019-02-19.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class AHContentView: UIViewController, UIGestureRecognizerDelegate {
    lazy var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Lorem ipsum dolor sit amen"
        l.font = .systemFont(ofSize: 22)
        l.textColor = .white
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addConstraints([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
            ])
        let closeButton = UIButton(frame: .zero)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.setTitle("Close", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        view.addConstraints([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(close(_:)))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }


    @objc func close(_ sender:UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
