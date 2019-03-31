//
//  FormatHelperTests.swift
//  MyTestCacheAppTests
//
//  Created by Mikael Olsson on 2019-03-31.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import XCTest

class FormatHelperTests: XCTestCase {
    
    func testThatConvertingIntervalToTextAndBackAgainWorks() {
       
        let inputDate = Date()
        let dateAsText = FormatHelper.dateToText(inputDate)
        let outputDate = FormatHelper.textToDate(dateAsText)
        
        let inputDateAsText = "\(inputDate)"
        let outputDateAsText = "\(outputDate)"

        XCTAssertEqual(outputDateAsText, inputDateAsText)
        
    }
    
    func testThatWeCanAddFiveSecondsToDateAndThenGetTheDifference() {
        
        let inputDate = Date()
        let inputDatePlus5000Millis = FormatHelper.addSecondsToDate(inputDate, 5)
        let diffInSeconds = FormatHelper.getDateDiffInSeconds(inputDate, inputDatePlus5000Millis)
        
        XCTAssertEqual(diffInSeconds, 5)
        
    }
    
    func testWeCanCreateACustomDateAndCastItToReadableFormat() {
        
        let customDate = FormatHelper.createCustomDate(2019, 1, 2, 3, 4, 5)
        let readableDate = FormatHelper.dateToReadableString(customDate)
       
        XCTAssertEqual(readableDate, "2019-01-02 03:04:05")
        
    }

}
