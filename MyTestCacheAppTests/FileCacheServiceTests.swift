//
//  FileCacheServiceTests.swift
//  MyTestCacheAppTests
//
//  Created by Mikael Olsson on 2019-04-01.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import XCTest

class FileCacheServiceTests: XCTestCase {

    var expireService : ExpireService? = nil
    var fileService : FileService? = nil
    var fileCacheService : FileCacheService? = nil
    var mockedTimeService : TimeService? = nil
    
    override func setUp() {
        expireService = ExpireProvider()
        fileService = FileProvider()
        
        let mockedDate = FormatHelper.createCustomDate(2019, 1, 2, 3, 4, 5)
        mockedTimeService = MockedTimeProvider(mockedDate)
        
        fileCacheService = FileCacheProvider(fileService: fileService!, expireService: expireService!, timeService: mockedTimeService!)
        
        fileService?.save("mykey.cache.expire-1565605979000", "123")
        fileService?.save("anotherkey.cache.expire-1565605979000", "456")
        fileService?.save("thirdkey.cache.no-expire", "789")

    }

    override func tearDown() {
        let files = fileService?.list()
        files?.forEach {
            fileService!.delete($0)
        }
    }
    
    func testThatKeysCanBeFound() {
        let keyExists = fileCacheService?.exists("anotherkey")
        XCTAssertTrue(keyExists!)
        
        let anotherKeyExists = fileCacheService?.exists("mykey")
        XCTAssertTrue(anotherKeyExists!)
        
        let thirdKeyExists = fileCacheService?.exists("thirdkey")
        XCTAssertTrue(thirdKeyExists!)
    }
    
    func testThatKeysCanNotBeFound() {
        let keyNotExists = fileCacheService?.exists("anotherkey2")
        XCTAssertFalse(keyNotExists!)
        
        let anotherKeyNotExists = fileCacheService?.exists("mykey2")
        XCTAssertFalse(anotherKeyNotExists!)
    }
    
    func testThatSavedKeyHasNoExpireFilename() {
        fileCacheService?.set("abc", "123")
        
        
        let files = fileService?.list()
        print("x")
    }

}
