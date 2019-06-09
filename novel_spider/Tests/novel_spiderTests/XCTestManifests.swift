import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(novel_spiderTests.allTests),
    ]
}
#endif
