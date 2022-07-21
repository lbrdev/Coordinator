//
//  SecondCoordinator.swift
//  CoordinatorExample
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import Coordinator
import UIKit

enum SecondRoute: Route {
    case firstState
    case secondState
}

class SecondCoordinator: NavigationCoordinator<SecondRoute> {
    override func start(with route: SecondRoute) {
        super.start(with: route)

        switch route {
        case .firstState:
            launchFirstState()
        case .secondState:
            launchSecondState()
        }
    }

    override var debug: Bool {
        return true 
    }

    private func launchFirstState() {
        let controller = StateViewController(state: .first)
        controller.present = { [unowned self] in
            launchSecondState()
        }
        controller.dismissAll = { [unowned self] in
            self.navigate(to: .dismissAll)
        }
        controller.push = { [unowned self] in
            self.launchFirstState()
        }
        controller.toRoot = { [unowned self] in
            self.navigate(to: .root)
        }
        navigate(to: .push(controller))
    }

    private func launchSecondState() {
        let controller = StateViewController(state: .second)
        controller.close = { [unowned self] in
            self.navigate(to: .dismissTop)
        }

        controller.present = { [unowned self] in
            launchSecondState()
        }
        controller.dismissAll = { [unowned self] in
            self.navigate(to: .dismissAll)
        }
        controller.definesPresentationContext = true
        navigate(to: .present(UINavigationController(rootViewController: controller)))
    }
}
