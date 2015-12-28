import XCTest

class StringByTrimmingWhitespaceAndNewline : StringByTrimmingSharedTests {

    // TODO: this needs to be passed as a pointer to function, without a need to override the method!
    override func trimmingMethod(string : String) -> String? {
        // I should use a pointer to a function in here instead!!
        return string.stringByTrimmingWhitespaceAndNewline()
    }

    func testNewlineNotTrimming() {
        let aWordAndNewline = "Champ \n"
        let trimmedString = trimmingMethod(aWordAndNewline)
        XCTAssertEqual("Champ", trimmedString, "string containing a word and a newline should return just the word after trimming whitespace and newline")
    }
}
