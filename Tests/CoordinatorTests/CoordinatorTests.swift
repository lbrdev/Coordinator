@testable import Coordinator
import Foundation
import XCTest

final class CoordinatorTests: XCTestCase {
    func testSavingMeta() {
        let coordinator = StubCoordinator()

        coordinator.start(with: .first)

        XCTAssertTrue(coordinator.meta == .first)
    }

    func testFinishing() {
        let coordinatorA = StubCoordinator()
        coordinatorA.start(with: .first)

        let coordinatorB = StubCoordinator()
        coordinatorB.onFinish = {
            coordinatorA.remove($0)
        }
        
        coordinatorA.add(coordinatorB)
        coordinatorB.start(with: .second)
        coordinatorB.finish()

        XCTAssertTrue(coordinatorA.coordinators.isEmpty)
    }
}
