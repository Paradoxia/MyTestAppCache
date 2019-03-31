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

}
