//
//  TimeService.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-04-01.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

protocol TimeService {
    
    func getCurrentDate() -> Date
    
}

extension TimeService {
    
    func getCurrentDate() -> Date {
        return Date()
    }
    
}
