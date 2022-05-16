//
//  RootViewController.swift
//  CoordinatorExample
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import UIKit

class RootViewController: UIViewController {
    public var push: () -> Void = {}
    public var present: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is root"

        var pushConfiguration = UIButton.Configuration.filled()
        pushConfiguration.title = "Push coordinator"
        pushConfiguration.buttonSize = .large

        let pushButton = UIButton(configuration: pushConfiguration)
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        
        var presentConfiguration = UIButton.Configuration.filled()
        presentConfiguration.title = "Present coordinator"
        presentConfiguration.buttonSize = .large
        
        let presentButton = UIButton(configuration: presentConfiguration)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.addTarget(self, action: #selector(presentAction), for: .touchUpInside)

        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(pushButton)
        pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pushButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(presentButton)
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.topAnchor.constraint(equalTo: pushButton.bottomAnchor, constant: 20).isActive = true
    }

    @objc func pushAction() {
        push()
    }
    
    @objc func presentAction() {
        present()
    }
}
