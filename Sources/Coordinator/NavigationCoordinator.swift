//
//  NavigationCoordinator.swift
//
//
//  Created by Ihor Kandaurov on 15.05.2022.
//

import Foundation
import UIKit

/// UINavigation stack coordinator with auto finish
open class NavigationCoordinator<M: CoordinationMeta>: Coordinator<M>, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    open var navigationController: UINavigationController

    public enum NavigationAction {
        case present(UIViewController)
        case push(UIViewController)
        case popTo(UIViewController)
        case set([UIViewController])
        case dismissTop
        case dismissAll
        case root
        case pop
    }

    public internal(set) var viewControllers: [UIViewController] = []
    public internal(set) var presentedViewControllers: [UIViewController] = []

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
        presentedViewControllers = []
        parent?.remove(asAny)
        super.finish()
    }

    open func navigate(
        to action: NavigationAction,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        switch action {
        case let .present(controller):
            presentedViewControllers.append(controller)
            controller.presentationController?.delegate = self
            navigationController.visibleViewController?.present(controller, animated: animated, completion: completion)
        case .dismissTop:
            presentedViewControllers.removeLast()
            navigationController.visibleViewController?.dismiss(animated: animated, completion: completion)
            if presentedViewControllers.isEmpty && viewControllers.isEmpty {
                finish()
            }
        case .dismissAll:
            presentedViewControllers = []
            navigationController.topViewController?.dismiss(animated: animated, completion: completion)
            if viewControllers.isEmpty {
                finish()
            }
        case let .push(controller):
            viewControllers.append(controller) // Updating of viewControllers
            navigationController.pushViewController(controller, animated: animated, completion: completion)
        case .root:
            // Updating of `viewControllers` observed by `pop(to destination:)`
            navigationController.popToRootViewController(animated: animated, completion: completion)
        case .pop:
            // Updating of `viewControllers` observed by `pop(to destination:)`
            navigationController.popViewController(animated: animated, completion: completion)
        case let .popTo(controller):
            // Updating of `viewControllers` observed by `pop(to destination:)`
            navigationController.popToViewController(controller, animated: animated, completion: completion)
        case let .set(controllers):
            viewControllers = controllers
            navigationController.setViewControllers(controllers, animated: animated)
            completion?()
        }
    }

    // Pop detection
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
    
    // Modal dismiss detection
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        presentedViewControllers.removeLast()
        if presentedViewControllers.isEmpty && viewControllers.isEmpty {
            finish()
        }
    }
}
