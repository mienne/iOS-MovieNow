import XCTest

@testable import BuildTools

final class BuildToolsTests: XCTestCase {

    func testExample() {
        XCTAssertEqual(BuildTools().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
