import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(MovieNowToolsTests.allTests)
        ]
    }
#endif
