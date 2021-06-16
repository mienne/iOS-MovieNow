import XCTest

@testable import MovieNowTools

final class MovieNowToolsTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(MovieNowTools().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
