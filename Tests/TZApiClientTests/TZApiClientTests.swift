import XCTest
@testable import TZApiClient

final class TZApiClientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TZApiClient().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
