//
//  FormatHelper.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-03-31.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

class FormatHelper {
    
    static func dateToText(_ date : Date) -> String {
        let dateAsInterval = date.timeIntervalSince1970
        return "\(dateAsInterval)"
    }
    
    static func textToDate(_ text : String) -> Date {
        let timeAsDouble = Double.init(text)
        let timeInterval = TimeInterval(timeAsDouble!)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
    
    static func addMilliSecToDate(_ date : Date,_ milliSec : Int) {
        
        
        
    }
    
}
