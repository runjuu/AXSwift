import Cocoa
import XCTest
@testable import AXSwift

final class ObserverTests: XCTestCase {
    func testFailedCreationThrowsWithoutCrashingDuringCleanup() {
        XCTAssertThrowsError(try Observer(processID: -1) { _, _, _ in }) { error in
            XCTAssertEqual(error as? AXError, .illegalArgument)
        }
    }

    func testFailedCreationWithInfoThrowsWithoutCrashingDuringCleanup() {
        XCTAssertThrowsError(try Observer(processID: -1) { _, _, _, _ in }) { error in
            XCTAssertEqual(error as? AXError, .illegalArgument)
        }
    }

    func testSuccessfulObserverCanStopRestartAndDeinitialize() throws {
        var observer: Observer? = try Observer(processID: getpid()) { _, _, _ in }
        weak var weakObserver = observer
        observer?.stop()
        observer?.stop()
        observer?.start()
        observer = nil
        XCTAssertNil(weakObserver)
    }

    func testSuccessfulObserverWithInfoCanStopRestartAndDeinitialize() throws {
        var observer: Observer? = try Observer(processID: getpid()) { _, _, _, _ in }
        weak var weakObserver = observer
        observer?.stop()
        observer?.stop()
        observer?.start()
        observer = nil
        XCTAssertNil(weakObserver)
    }
}
