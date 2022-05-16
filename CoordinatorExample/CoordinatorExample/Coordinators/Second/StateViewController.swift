//
//  StateViewController.swift
//  CoordinatorExample
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import UIKit

class StateViewController: UIViewController {
    enum State: String {
        case first
        case second
    }

    public var close: (() -> Void) = { }
    public var push: (() -> Void) = { }
    public var present: (() -> Void) = { }
    public var dismissAll: (() -> Void) = { }
    public var toRoot: (() -> Void) = { }

    public init(state: State) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let state: State

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = state == .first ? .systemBackground : .systemBlue
        title = state.rawValue

        if state == .second {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .close,
                target: self,
                action: #selector(closeAction)
            )
        }

        var presentConfiguration = UIButton.Configuration.filled()
        presentConfiguration.title = "Present"
        presentConfiguration.buttonSize = .large
        presentConfiguration.baseBackgroundColor = .white
        presentConfiguration.baseForegroundColor = .systemBlue

        let presentButton = UIButton(configuration: presentConfiguration)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.addTarget(self, action: #selector(presentAction), for: .touchUpInside)

        view.addSubview(presentButton)
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        if state == .second {
            var dismissConfiguration = UIButton.Configuration.filled()
            dismissConfiguration.title = "Dismis All"
            dismissConfiguration.buttonSize = .large
            dismissConfiguration.baseBackgroundColor = .white
            dismissConfiguration.baseForegroundColor = .systemBlue

            let dismissButton = UIButton(configuration: dismissConfiguration)
            dismissButton.translatesAutoresizingMaskIntoConstraints = false
            dismissButton.addTarget(self, action: #selector(dismissAllAction), for: .touchUpInside)

            view.addSubview(dismissButton)
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            dismissButton.topAnchor.constraint(equalTo: presentButton.bottomAnchor, constant: 20).isActive = true
        } else {
            var pushConfiguration = UIButton.Configuration.filled()
            pushConfiguration.title = "Push"
            pushConfiguration.buttonSize = .large
            pushConfiguration.baseBackgroundColor = .white
            pushConfiguration.baseForegroundColor = .systemBlue

            let pushButton = UIButton(configuration: pushConfiguration)
            pushButton.translatesAutoresizingMaskIntoConstraints = false
            pushButton.addTarget(self, action: #selector(pushAction), for: .touchUpInside)

            view.addSubview(pushButton)
            pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            pushButton.topAnchor.constraint(equalTo: presentButton.bottomAnchor, constant: 20).isActive = true

            var toRootConfiguration = UIButton.Configuration.filled()
            toRootConfiguration.title = "To root"
            toRootConfiguration.buttonSize = .large
            toRootConfiguration.baseBackgroundColor = .white
            toRootConfiguration.baseForegroundColor = .systemBlue

            let toRootButton = UIButton(configuration: toRootConfiguration)
            toRootButton.translatesAutoresizingMaskIntoConstraints = false
            toRootButton.addTarget(self, action: #selector(toRootAction), for: .touchUpInside)

            view.addSubview(toRootButton)
            toRootButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            toRootButton.topAnchor.constraint(equalTo: pushButton.bottomAnchor, constant: 20).isActive = true
        }
    }

    @objc func closeAction() {
        close()
    }

    @objc func presentAction() {
        present()
    }

    @objc func pushAction() {
        push()
    }

    @objc func toRootAction() {
        toRoot()
    }

    @objc func dismissAllAction() {
        dismissAll()
    }
}
