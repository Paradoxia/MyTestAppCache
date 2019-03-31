//
//  FileService.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-04-01.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

protocol FileService {
    
    func save(_ filename : String,_ value : String?)
    func list() -> Array<String>
    func delete(_ filename : String)
    func load(_ filename : String) -> String?
    func exist(_ filename : String) -> Bool
    
}
