//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Ihor Kandaurov on 16.05.2022.
//

import UIKit
import Coordinator

struct AppMeta: CoordinationMeta {}

class AppCoordinator: NavigationCoordinator<AppMeta> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: UINavigationController())
    }
    
    override func start(with meta: AppMeta) {
        super.start(with: meta)
        
        navigate(to: .set([RootViewController()]))
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
