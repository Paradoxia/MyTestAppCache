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
        fileService = MemoryFileProvider()
        
        let mockedDate = FormatHelper.createCustomDate(2019, 1, 2, 3, 4, 5)
        mockedTimeService = MockedTimeProvider(mockedDate)
        
        fileCacheService = FileCacheProvider(fileService: fileService!, expireService: expireService!, timeService: mockedTimeService!)
        
        // Let's add some dummy cache files
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
    
    func testThatKeysCanBeFoundUsingExistsMethod() {
        let keyExists = fileCacheService?.exists("anotherkey")
        XCTAssertTrue(keyExists!)
        
        let anotherKeyExists = fileCacheService?.exists("mykey")
        XCTAssertTrue(anotherKeyExists!)
        
        let thirdKeyExists = fileCacheService?.exists("thirdkey")
        XCTAssertTrue(thirdKeyExists!)
    }
    
    func testThatKeysCanNotBeFoundWhenUsingExistsMethod() {
        let keyNotExists = fileCacheService?.exists("anotherkey2")
        XCTAssertFalse(keyNotExists!)
        
        let anotherKeyNotExists = fileCacheService?.exists("mykey2")
        XCTAssertFalse(anotherKeyNotExists!)
    }
    
    /*
        Here we test that the data we set receives a filename
        from the FileCacheService that contains an no-expire extension.
     */
    func testThatSavedKeyWithoutTTLHasANoExpireFileExtension() {
        fileCacheService?.set("abc", "123")
        let files = fileService?.list()
        let fileWithNoExpireExtension = files!.contains("abc.cache.no-expire")
        XCTAssertTrue(fileWithNoExpireExtension)
    }
    
    /*
        Here we test that the data we set receives a filename
        from the FileCacheService that contains an expire timestamp.
        Since we override the TimeService (see setUp above) we know
        exactly the expected timestamp when setting a TTL (time-to-live)
        of five seconds.
    */
    func testThatSavedKeyWithFiveSecondTTLHasAnExpireFileExtension() {
        fileCacheService?.set("abc", "123", 5)
        let files = fileService?.list()
        let fileWithExpireExtension = files!.contains("abc.cache.expire-1546394650000")
        XCTAssertTrue(fileWithExpireExtension)
    }
    
    func testThatSavedKeyWithFiveSecondTTLHasAnExistingKey() {
        fileCacheService?.set("abc", "123", 5)
        let keyExists = fileCacheService?.exists("abc")
        XCTAssertTrue(keyExists!)
    }

    func testThatSavedKeyWithFiveSecondTTLIsDeletedDueToExpire() {
        // "set" method will internally use our mocked TimeService
        // and set TTL expire date to our static date + 5 seconds.
        fileCacheService?.set("abc", "123", 5)
        
        // "exists" method will internally use our mocked TimeService
        // that will return our mocked static date (see setUp above).
        let keyExists = fileCacheService?.exists("abc")
        XCTAssertTrue(keyExists!)
        
        let numOfCacheFiles = fileService?.list().count
        XCTAssertEqual(4, numOfCacheFiles!)
        
        // Now lets implement a new TimeService that will grab the real system time.
        struct TimeProvider : TimeService {}
        let realTimeService = TimeProvider()
        
        fileCacheService = FileCacheProvider(fileService: fileService!, expireService: expireService!, timeService: realTimeService)
        
        // Let's add some dummy cache files
        fileService?.save("mykey.cache.expire-1565605979000", "123")
        fileService?.save("anotherkey.cache.expire-1565605979000", "456")
        fileService?.save("thirdkey.cache.no-expire", "789")
        
        // This time when we call "exists" it will internally use our new TimeService
        // that actually uses the real system time. This will make the key "abc"
        // expired and make FileCacheService delete the key from storage.
        let keyNotExists = fileCacheService?.exists("abc")

        XCTAssertFalse(keyNotExists!)
        
        let numOfCacheFilesMinusOne = fileService?.list().count
        XCTAssertEqual(3, numOfCacheFilesMinusOne!)
    }
    
    func testThatWeCanLoadValueFromKeyWithoutExpireDate() {
        fileCacheService?.set("qwerty", "poiuyt")
        let value = fileCacheService?.load("qwerty")
        XCTAssertEqual("poiuyt", value)
    }
    
    func testThatWeCanNotLoadValueFromKeyThatDoesNotExist() {
        let value = fileCacheService?.load("qwerty")
        XCTAssertNil(value)
    }

    func testThatWeCanLoadValueFromKeyWithTTLOfFiveSeconds() {
        fileCacheService?.set("qwerty", "poiuyt", 5)
        let value = fileCacheService?.load("qwerty")
        XCTAssertEqual("poiuyt", value)
    }
    
    func testThatWeCantLoadValueFromKeyWithTTLOfFiveSecondsDueToExpire() {
        fileCacheService?.set("qwerty", "poiuyt", 5)
        
        // Now lets implement a new TimeService that will grab the real system time.
        struct TimeProvider : TimeService {}
        let realTimeService = TimeProvider()
        
        fileCacheService = FileCacheProvider(fileService: fileService!, expireService: expireService!, timeService: realTimeService)
        
        let value = fileCacheService?.load("qwerty")
        XCTAssertNil(value)
    }
    
    func testThatSavedKeyWithoutTTLExpireDateIsRemoved() {
        fileCacheService?.set("abc", "123")
        let keyExists = fileCacheService?.exists("abc")
        XCTAssertTrue(keyExists!)
        
        fileCacheService?.remove("abc")
        let keyNotExists = fileCacheService?.exists("abc")
        XCTAssertFalse(keyNotExists!)
     }
    
    func testThatSavedKeyWithTTLExpireDateIsRemoved() {
        fileCacheService?.set("abc", "123", 9999)
        let keyExists = fileCacheService?.exists("abc")
        XCTAssertTrue(keyExists!)
        
        fileCacheService?.remove("abc")
        let keyNotExists = fileCacheService?.exists("abc")
        XCTAssertFalse(keyNotExists!)
    }
    
    
}
