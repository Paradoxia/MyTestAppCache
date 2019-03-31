//
//  ExtensionTests.swift
//  MyTestCacheAppTests
//
//  Created by Mikael Olsson on 2019-03-31.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import XCTest

class ExtensionTests: XCTestCase {

    func testThatWeCanConvertDateToMilliSecondsAndBackAgain() {

        let inputDate = Date()
        
        // Please look at the DateExtension class which add
        // .toMillis and a constructor to the system Data object
        let dateAsMilliSeconds = inputDate.toMillis()
        let outputDate = Date(millis : dateAsMilliSeconds!)

        let inputDateAsText = "\(inputDate)"
        let outputDateAsText = "\(outputDate)"
        
        XCTAssertEqual(outputDateAsText, inputDateAsText)
        
    }


}
