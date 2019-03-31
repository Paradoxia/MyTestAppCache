//
//  ExpireProvider.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-03-31.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

struct ExpireProvider : ExpireService {

    let expireExt : String = ".expire-"
    let noExpireExt : String = ".no-expire"
    
    func createFilenameWithExpireDate(_ filename: String,_ date: Date) -> String {
        return "\(filename)\(expireExt)\(date.toMillis()!)"
    }
    
    func createFilenameWithNoExpireDate(_ filename: String) -> String {
        return "\(filename)\(noExpireExt)"
    }
    
    func dateFromFilename(_ filenameWithExpireDate: String) -> Date? {
        
        if(filenameWithExpireDate.contains(expireExt)) {
            let parts = filenameWithExpireDate.components(separatedBy: expireExt)
            if(parts.count > 1) {
                let dateInMillis = Int64(parts[1])
                let dateFromMillis = Date(millis: dateInMillis!)
                return dateFromMillis
            } else {
                return nil
            }
        } else {
            return nil
        }

    }
    
    func hasExpired(_ filenameWithExpireDate: String,_ currentDate : Date) -> Bool {
        
        let expireDate = dateFromFilename(filenameWithExpireDate)
        if(expireDate != nil) {
            let diff = FormatHelper.getDateDiffInSeconds(expireDate!, currentDate)
            return diff > 0
        } else {
            return false
        }
        
    }
    
}
