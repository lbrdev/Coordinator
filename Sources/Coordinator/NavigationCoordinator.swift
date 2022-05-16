//
//  NavigationCoordinator.swift
//
//
//  Created by Ihor Kandaurov on 15.05.2022.
//

import Foundation
import UIKit

open class NavigationCoordinator<M: CoordinationMeta>: Coordinator<M>, UINavigationControllerDelegate {
    open var navigationController: UINavigationController

    public enum NavigationAction {
        case present(UIViewController)
        case push(UIViewController)
        case popTo(UIViewController)
        case dismiss
        case root
        case pop
    }

    open internal(set) var viewControllers: [UIViewController] = []

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    override open func start(with meta: M) {
        super.start(with: meta)

        navigationController.delegate = self
    }

    override open func finish() {
        navigationController.delegate = nil
        navigationController.viewControllers.removeAll { viewControllers.contains($0) }
        viewControllers = []
        super.finish()
    }

    open func navigate(
        to action: NavigationAction,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        switch action {
        case let .present(controller):
            navigationController.present(controller, animated: animated, completion: completion)
        case .dismiss:
            navigationController.dismiss(animated: animated)
        case let .push(controller):
            navigationController.pushViewController(controller, animated: animated, completion: completion)
        case .root:
            navigationController.popToRootViewController(animated: animated, completion: completion)
        case .pop:
            navigationController.popViewController(animated: animated, completion: completion)
        case let .popTo(controller):
            navigationController.popToViewController(controller, animated: animated, completion: completion)
        }
    }

    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Detection of animated transition
        guard let sender = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        // If navigationController.viewControllers still contains our sender then it's push,
        // and we're ignore this action
        guard !navigationController.viewControllers.contains(sender) else { return }

        pop(to: viewController)
    }

    private func pop(to destination: UIViewController) {
        guard !viewControllers.isEmpty else {
            // No controllers in stack
            finish()
            return
        }

        guard destination !== viewControllers.last else { return }

        // Check if sender is in our coordination stack
        guard let destinationIndex = viewControllers.firstIndex(of: destination) else {
            // If it's not, we're probably focused in another `NavigationCoordinator`
            finish()
            return
        }

        // Destination index should be lower than last index in our stack
        guard let lastIndex = viewControllers.indices.last,
              destinationIndex < lastIndex else { return }

        viewControllers.removeSubrange(destinationIndex ... lastIndex)
    }
}
