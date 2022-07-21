//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import Coordinator
import UIKit

enum AppRoute: Route {
    case standart
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: UINavigationController())
    }

    override func start(with route: AppRoute) {
        super.start(with: route)

        let root = RootViewController()
        navigate(to: .set([root]))
        root.push = { [unowned self] in
            self.startSecondPush()
        }

        root.present = { [unowned self] in
            self.startSecondPresent()
        }

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        coordinators.first?.start(with: route)
    }

    private func startSecondPush() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        add(secondCoordinator)
        secondCoordinator.start(with: .firstState)
    }

    private func startSecondPresent() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        add(secondCoordinator)
        secondCoordinator.start(with: .secondState)
    }
}
