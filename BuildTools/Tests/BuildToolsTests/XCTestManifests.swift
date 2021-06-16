import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(BuildToolsTests.allTests),
        ]
    }
#endif
