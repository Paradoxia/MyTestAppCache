//
//  ExpireService.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-03-31.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

protocol ExpireService {
    
    func createFilenameWithExpireDate(_ filename : String,_ date : Date) -> String
    func createFilenameWithNoExpireDate(_ filename : String) -> String
    func dateFromFilename(_ filenameWithExpireDate : String) -> Date?
    func hasExpired(_ filenameWithExpireDate : String, _ currentDate : Date) -> Bool
    
}
