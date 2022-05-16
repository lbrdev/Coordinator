//
//  RootViewController.swift
//  CoordinatorExample
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import UIKit


class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is root"

        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
