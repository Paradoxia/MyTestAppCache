//
//  TempFileProvider.swift
//  MyTestCacheApp
//
//  Created by Mikael Olsson on 2019-04-03.
//  Copyright © 2019 Mikael Olsson. All rights reserved.
//

import Foundation

class TempFileProvider : FileService {
    
    let tempDir = NSTemporaryDirectory()
    
    func save(_ filename: String,_ value: String?) {
        let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent(filename)
        if(value != nil) {
            do {
                try value!.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
            
            }
        }
    }
    
    func list() -> Array<String> {
        let fileManager = FileManager.init()
        do {
            let files = try fileManager.contentsOfDirectory(atPath: tempDir)
            return Array(files)
        } catch {
            return [String]()
        }
    }
    
    func delete(_ filename: String) {
        let fileManager = FileManager.init()
        let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent(filename)
        do {
            try fileManager.removeItem(at: fileURL)
        } catch {

        }
    }
    
    func load(_ filename: String) -> String? {
        let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent(filename)
        do {
            let readString = try String(contentsOf: fileURL, encoding: .utf8)
            return readString
        } catch {
            return nil
        }
    }
    
    func exist(_ filename: String) -> Bool {
        let fileManager = FileManager.init()
        let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent(filename)
        return fileManager.fileExists(atPath: fileURL.absoluteString)
    }
    
}
