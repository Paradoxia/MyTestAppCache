//
//  FileProvider.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-04-01.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

class FileProvider : FileService {

    var files: [String: String] = [:]
    
    func save(_ filename: String,_ value: String?) {
        files[filename] = value
    }
    
    func list() -> Array<String> {
        return Array(files.keys)
    }
    
    func delete(_ filename: String) {
        files[filename] = nil
    }
    
    func load(_ filename: String) -> String? {
        return files[filename]
    }
    
    func exist(_ filename: String) -> Bool {
        return files.keys.contains(filename)
    }
    
}
