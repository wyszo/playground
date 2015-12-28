import XCTest

class OSTaskExecutorTests : XCTestCase {
    let taskExecutor = OSTaskExecutor()

    func testExcecuteEmptyPathShouldFail() {
        let (output, success) = taskExecutor.systemCommandWithLaunchPath("", arguments: "")
        XCTAssertEqual(nil, output, "task executor should return nil when launchPath and arguments empty")
        XCTAssertFalse(success, "task executor should return false as a success status")
    }

    func testExecuteLs() {
        XCTAssertFalse(true, "not implemented yet")
    }

    func testExecuteGitWithNoParameters() {
        XCTAssertFalse(true, "not implemented yet")
    }

    func testExecuteGitWithSomeParameters() {
        XCTAssertFalse(true, "not implemented yet")
    }
}