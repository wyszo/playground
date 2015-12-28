import XCTest

// TODO: somehow ensure this base class tests don't get executed when running unit tests!
class StringByTrimmingSharedTests : XCTestCase {

    override func performTest(run: XCTestRun) {
        if self.dynamicType == StringByTrimmingSharedTests.self {
            return; // Don't run any tests if we're in abstract base class!
        } else {
            super.performTest(run)
        }
    }

    // TODO: this needs to be passed as a pointer to function, without a need to override the method!
    func trimmingMethod(string : String) -> String? {
        return nil
    }


    func testEmptyString() {
        let emptyString = ""
        let trimmedString = trimmingMethod(emptyString)
        XCTAssertEqual(emptyString, trimmedString, "empty string should not change after operation")
    }

    func testSingleSpace() {
        let singleSpaceString = " "
        let trimmedString = trimmingMethod(singleSpaceString)
        XCTAssertEqual("", trimmedString, "string containing space should be empty after operation")
    }

    func testSingleSpaceAndALetter() {
        let singleSpaceAndALetterString = " a"
        let trimmedString = trimmingMethod(singleSpaceAndALetterString)
        XCTAssertEqual("a", trimmedString, "string containing space and a letter should contain just a letter after operation")
    }

    func testLetterAndSpace() {
        let singleLetterAndSpaceString = "b "
        let trimmedString = trimmingMethod(singleLetterAndSpaceString)
        XCTAssertEqual("b", trimmedString, "string containing letter and a space should just contain a letter after operation")
    }

    func testMultipleLeadingSpacesAndAWord() {
        let multipleSpacesAndAWord = "    CAT"
        let trimmedString = trimmingMethod(multipleSpacesAndAWord)
        XCTAssertEqual("CAT", trimmedString, "string containing multiple leading spaces and a word should just contain the word after operation")
    }

    func testAWordAndMultipleTrailingSpaces() {
        let aWordAndMultipleTrailingSpaces = "dog    "
        let trimmedString = trimmingMethod(aWordAndMultipleTrailingSpaces)
        XCTAssertEqual("dog", trimmedString, "string containing a word and multiple trailing spaces should just contain the word after operation")
    }

    func testAWordAndLeadingAndTrailingSpace() {
        let aWordAndLeadingAndTrailingSpace = " Elephant "
        let trimmedString = trimmingMethod(aWordAndLeadingAndTrailingSpace)
        XCTAssertEqual("Elephant", trimmedString, "string containing a word and a leading and trailing space should just contain the word after operation")
    }

    func testMultipleWordsAndLeadingAndTrailingSpace() {
        let aWordAndMultipleLeadingAndTrailingSpaces = "     House  "
        let trimmedString = trimmingMethod(aWordAndMultipleLeadingAndTrailingSpaces)
        XCTAssertEqual("House", trimmedString, "string containing a word and multiple leading and trailing spaces should just contain the word after operation")
    }

    func testMultipleWordsAndMultipleTrailingSpaces() {
        let multipleWordsAndMultipleLeadingAndTrailingSpaces = "    Oven Digital    Rose   "
        let trimmedString = trimmingMethod(multipleWordsAndMultipleLeadingAndTrailingSpaces)
        XCTAssertEqual("Oven Digital    Rose", trimmedString, "string containing multiple words and multiple leading and trailing spaces should just contain those words after operation")
    }

    func testTabulationTrimming() {
        let aWordAndTabulation = "\t    Tree    \t"
        let trimmedString = trimmingMethod(aWordAndTabulation)
        XCTAssertEqual("Tree", trimmedString, "string containing a word and tabulation should just contain this word after operation")
    }
}
