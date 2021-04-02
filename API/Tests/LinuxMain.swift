import XCTest

import APITests

var tests = [XCTestCaseEntry]()
tests += APITests.allTests()
XCTMain(tests)
