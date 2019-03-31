//
//  DateExtension.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-03-31.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation


// Extension expressions allow us to extend system objects with new methods.
// In this case we add "toMillis" and a new constructor to the system Date object
extension Date {
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    init(millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis / 1000))
        self.addTimeInterval(TimeInterval(Double(millis % 1000) / 1000 ))
    }
    
}
