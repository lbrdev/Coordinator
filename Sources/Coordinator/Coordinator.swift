//
//  Coordinator.swift
//
//
//  Created by Ihor Kandaurov on 15.05.2022.
//

import Foundation

public protocol MutableCoordinator: AnyObject {
    var coordinators: [AnyCoordinator] { get set }
    var asAny: AnyCoordinator { get }
    /// Appends `coordinators` whith a new one.
    func add<R: Route, C: Coordinator<R>>(_ coordinator: C)
    /// Removes a coordiantor from `coordinators` using type.
    func remove<R: Route, C: Coordinator<R>>(_ coordinatorType: C.Type)
    /// Removes a coordiantor from `coordinators` using coordinator instance.
    func remove<R: Route, C: Coordinator<R>>(_ coordinator: C)
    func remove(_ anyCoordinator: AnyCoordinator)
    /// Removes all coordiantors from `coordinators`.
    func removeAll()
}

public extension MutableCoordinator {
    func add<R: Route, C: Coordinator<R>>(
        _ coordinator: C
    ) {
        coordinators.append(coordinator.asAny)
        coordinator.parent = asAny
    }

    func remove<R: Route, C: Coordinator<R>>(
        _ coordinatorType: C.Type
    ) {
        coordinators.removeAll { type(of: $0.coordinator) == coordinatorType }
    }

    func remove<R: Route, C: Coordinator<R>>(
        _ coordinator: C
    ) {
        remove(type(of: coordinator))
    }

    func remove(_ anyCoordinator: AnyCoordinator) {
        coordinators.removeAll { $0.id == anyCoordinator.id }
    }

    func removeAll() {
        coordinators.removeAll()
    }
}

/// Base class to operate with flow using coordination pattern
open class Coordinator<R: Route>: NSObject, MutableCoordinator {
    /// Property to store type-erased coordinators.
    ///
    /// Use mutating functions.
    public var coordinators: [AnyCoordinator] = []

    /// Callback that triggers after `finish()`.
    public var onFinish: ((Coordinator<R>) -> Void)?

    /// Callback that triggers after `start(with)`.
    public var onStart: ((R) -> Void)?

    /// Parent that holds current coordinator
    public internal(set) var parent: AnyCoordinator?

    public var asAny: AnyCoordinator {
        AnyCoordinator(self)
    }

    /// Override to see a log messages
    open var debug: Bool { return false }

    override public init() {
        super.init()
        if debug {
            print("Init coordinator: \(String(describing: self))")
        }
    }

    deinit {
        if debug {
            print("Deinit coordinator: \(String(describing: self))")
        }
    }

    /// Override this method to get access to route
    open func start(with route: R) {
        if debug {
            print("Coordinator started with route: \(route)")
        }
        onStart?(route)
    }

    open func finish() {
        if debug {
            print("Coordinator is finished: \(String(describing: self))")
        }
        onFinish?(self)
    }
}
