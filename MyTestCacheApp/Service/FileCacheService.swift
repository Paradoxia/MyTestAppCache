//
//  FileCacheService.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-04-01.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

protocol FileCacheService {
    
    func exists(_ key : String) -> Bool
    func set(_ key : String,_ value : String?)
    func set(_ key : String,_ value : String?, _ ttlInSec : Int64)
    func remove(_ key : String)
    func load(_ key : String) -> String?
    func keys() -> Array<String>
    
}
