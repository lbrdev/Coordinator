//
//  NavigationCoordinator.swift
//  
//
//  Created by Ihor Kandaurov on 15.05.2022.
//

import Foundation
import UIKit

open class NavigationCoordinator<M: CoordinationMeta>: Coordinator<M> {
    
    open var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
}
