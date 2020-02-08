import XCTest
@testable import ADChronicle

@available(OSX 10.14, *)
@available(iOS 12.0, *)
final class ADChronicleTests: XCTestCase {
    func test_loggerIsCached() {
        let logger = ADChronicle.logger(for: #file)
        
        XCTAssertTrue(ADChronicle.loggers.values.contains(logger))
    }
}

@available(OSX 10.14, *)
@available(iOS 12.0, *)
final class ADChronicleLoggersStartupTests: XCTestCase {
    func test_noLoggersOnInit() {
        XCTAssertTrue(ADChronicle.loggers.isEmpty)
    }
}
