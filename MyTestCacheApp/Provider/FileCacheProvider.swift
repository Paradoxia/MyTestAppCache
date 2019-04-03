//
//  FileCacheProvider.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-04-01.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

struct FileCacheProvider : FileCacheService {
    
    let fileService : FileService
    let expireService : ExpireService
    let timeService : TimeService
    
    init(fileService : FileService, expireService : ExpireService, timeService : TimeService ) {
        self.fileService = fileService
        self.expireService = expireService
        self.timeService = timeService
    }
    
    func exists(_ key: String) -> Bool {
        let fileFound = findFileByFilenamePrefix(key)
        if(fileFound != nil) {
            let hasExpired = expireService.hasExpired(fileFound!, timeService.getCurrentDate())
            if(hasExpired) {
                fileService.delete(fileFound!)
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func set(_ key: String, _ value: String?) {
        deleteIfFilenameExists(key)
        let cacheKey = "\(key).cache"
        let filenameWithNoExpireDate = expireService.createFilenameWithNoExpireDate(cacheKey)
        fileService.save(filenameWithNoExpireDate, value)
    }
    
    func set(_ key: String, _ value: String?, _ ttlInSec: Int64) {
        deleteIfFilenameExists(key)
        let cacheKey = "\(key).cache"
        
        let currentDate = timeService.getCurrentDate()
        let expireDate = FormatHelper.addSecondsToDate(currentDate, ttlInSec)
        
        let filenameWithExpireDate = expireService.createFilenameWithExpireDate(cacheKey, expireDate)
        fileService.save(filenameWithExpireDate, value)
    }
    
    func keys() -> Array<String> {
        let files = fileService.list()
        return Array(files)
    }
    
    func remove(_ key: String) {
        let fileFound = findFileByFilenamePrefix(key)
        if(fileFound != nil) {
            fileService.delete(fileFound!)
        }
    }
    
    func load(_ key: String) -> String? {
        if(exists(key)) {
            let fileFound = findFileByFilenamePrefix(key)
            if(fileFound != nil) {
                let value = fileService.load(fileFound!)
                return value
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func findFileByFilenamePrefix(_ filenamePrefix : String) -> String? {
        let files = fileService.list()
        if let matchingFilename = files.first(where : {
            return $0.starts(with: "\(filenamePrefix).cache.") 
        }) {
            return matchingFilename
        } else {
            return nil
        }
    }
    
    func deleteIfFilenameExists(_ filenamePrefix : String) {
        let existingFilename = findFileByFilenamePrefix(filenamePrefix)
        if(existingFilename != nil) {
            fileService.delete(existingFilename!)
        }
    }
    
}
