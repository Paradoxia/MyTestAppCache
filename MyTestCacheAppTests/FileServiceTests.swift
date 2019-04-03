//
//  FileServiceTests.swift
//  MyTestCacheAppTests
//
//  Created by Mikael Olsson on 2019-04-01.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import XCTest

class FileServiceTests: XCTestCase {

    var fileService : MemoryFileProvider?
    
    override func setUp() {
        fileService = MemoryFileProvider()
    }

    override func tearDown() {
        let files = fileService?.list()
        files?.forEach {
            fileService!.delete($0)
        }
    }
    
    func testThatFilenameExistsWorks() {
        fileService?.files["dummy-file.txt"] = "somevalue"
        XCTAssertTrue(fileService!.exist("dummy-file.txt"))
    }
    
    func testThatFilenameNotExistingReturnsFalse() {
        fileService?.files["dummy-file.txt"] = "somevalue"
        XCTAssertFalse(fileService!.exist("dummy-another-file.txt"))
    }
    
    
    func testSavingUsingFilenameWorks() {
        fileService?.save("abc.txt", "123")
        XCTAssertTrue(fileService!.exist("abc.txt"))
    }

    func testListFilenamesWorks() {
        fileService?.save("abc.txt", "123")
        fileService?.save("def.txt", "456")
        fileService?.save("ghi.txt", "789")
        var files = fileService?.list()
        
        XCTAssertEqual(3, files?.count)
        
        files?.sort()
        
        XCTAssertEqual(files![0], "abc.txt")
        XCTAssertEqual(files![1], "def.txt")
        XCTAssertEqual(files![2], "ghi.txt")
    }
    
    func testDeleteByFilenameWorks() {
        fileService?.save("abc.txt", "123")
        fileService?.save("def.txt", "456")
        fileService?.save("ghi.txt", "789")
        
        fileService?.delete("def.txt")
        
        var files = fileService?.list()
        
        XCTAssertEqual(2, files?.count)
        
        files?.sort()
        
        XCTAssertEqual(files![0], "abc.txt")
        XCTAssertEqual(files![1], "ghi.txt")
    }
    
    func testLoadByFilenameWorks() {
        fileService?.save("abc.txt", "mikael")
        let shouldBeMikael = fileService?.load("abc.txt")
        
        XCTAssertEqual(shouldBeMikael, "mikael")
    }

}
