//
//  MockedTimeService.swift
//  MyTestCacheAppTests
//
//  Created by Mikael Olsson on 2019-04-01.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

struct MockedTimeProvider : TimeService {
    let mockedDate : Date
    init(_ date : Date) {
        self.mockedDate = date
    }
    func getCurrentDate() -> Date {
        return self.mockedDate
    }
}
