//
//  ExpireServiceTests.swift
//  MyTestCacheAppTests
//
//  Created by Mikael Olsson on 2019-03-31.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import XCTest

class ExpireServiceTests: XCTestCase {

    func testThatWeGetAFilenameWithExpireDate() {
        
        let expireProvider = ExpireProvider()
        let customDate = FormatHelper.createCustomDate(2019, 8, 12, 12, 32, 59)
        let filenameWithTimestamp = expireProvider.createFilenameWithExpireDate("mykey.cache", customDate)
        
        XCTAssertEqual(filenameWithTimestamp, "mykey.cache.expire-1565605979000")
        
    }
    
    func testThatWeGetAFilenameWithNoExpireDate() {
        
        let expireProvider = ExpireProvider()
        let filenameWithTimestamp = expireProvider.createFilenameWithNoExpireDate("mykey.cache")
        
        XCTAssertEqual(filenameWithTimestamp, "mykey.cache.no-expire")
        
    }

    func testWeCanGetDateFromFilenameWithExpireDate() {
        
        let expireProvider = ExpireProvider()
        let dummyFilenameWithExpireDate = "mykey.cache.expire-1565605979000"
        let expireDateFromFileName = expireProvider.dateFromFilename(dummyFilenameWithExpireDate)
        let readableDate = FormatHelper.dateToReadableString(expireDateFromFileName!)

        XCTAssertEqual(readableDate, "2019-08-12 12:32:59")
        
    }
    
    func testWeGetNilDateWhenExpireDateDoesNotExist() {
        
        let expireProvider = ExpireProvider()
        let dummyFilenameWithExpireDate = "mykey.cache.missing.expire.anything"
        let expireDateFromFileNameNil = expireProvider.dateFromFilename(dummyFilenameWithExpireDate)
        
        XCTAssertNil(expireDateFromFileNameNil)
        
    }
    
    func testWeGetNilDateWhenNoExpireDateExist() {
        
        let expireProvider = ExpireProvider()
        let dummyFilenameWithExpireDate = "mykey.cache.no-expire"
        let expireDateFromFileNameNil = expireProvider.dateFromFilename(dummyFilenameWithExpireDate)
        
        XCTAssertNil(expireDateFromFileNameNil)
        
    }
    
    func testThatExpireDateHasNotExpired() {
        
        let expireProvider = ExpireProvider()
        let expireDate = FormatHelper.createCustomDate(2019, 8, 12, 12, 32, 59) // Expire date = 2019-08-12 12:32:59
        let filenameWithExpireDate = expireProvider.createFilenameWithExpireDate("mykey.cache", expireDate)
        let mockedCurrentDate = FormatHelper.createCustomDate(2019, 7, 12, 12, 32, 59) // Mocked current date = 2019-07-12 12:32:59
        let hasNotExpired = expireProvider.hasExpired(filenameWithExpireDate, mockedCurrentDate)
        
        XCTAssertFalse(hasNotExpired)
        
    }
    
    func testThatExpireDateHasExpired() {
        
        let expireProvider = ExpireProvider()
        let expireDate = FormatHelper.createCustomDate(2019, 8, 12, 12, 32, 59) // Expire date = 2019-08-12 12:32:59
        let filenameWithExpireDate = expireProvider.createFilenameWithExpireDate("mykey.cache", expireDate)
        let mockedCurrentDate = FormatHelper.createCustomDate(2019, 8, 12, 12, 33, 0) // Mocked current date = 2019-08-12 12:33:00
        let hasExpired = expireProvider.hasExpired(filenameWithExpireDate, mockedCurrentDate)
        
        XCTAssertTrue(hasExpired)
        
    }




}
