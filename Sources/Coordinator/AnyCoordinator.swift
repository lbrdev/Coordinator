//
//  AnyCoordinator.swift
//
//
//  Created by Ihor Kandaurov on 15.05.2022.
//

import Foundation

/// Type erasure for `Coordinator`
public class AnyCoordinator: Identifiable {
    public let coordinator: Any
    public let id: String

    public func remove(_ anyCoordinator: AnyCoordinator) {
        removeAction(anyCoordinator)
    }

    public func start<R: Route>(with route: R) {
        startAction(route)
    }

    private let removeAction: (AnyCoordinator) -> Void
    private let startAction: (Route) -> Void

    public init<R: Route, C: Coordinator<R>>(_ coordinator: C) {
        self.coordinator = coordinator
        removeAction = { [unowned coordinator] anyCoordinator in
            coordinator.remove(anyCoordinator)
        }
        startAction = { [unowned coordinator] route in
            coordinator.start(with: route as! R)
        }
        id = String(describing: ObjectIdentifier(coordinator))
    }
}

extension AnyCoordinator: Equatable, Hashable {
    public static func == (lhs: AnyCoordinator, rhs: AnyCoordinator) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
