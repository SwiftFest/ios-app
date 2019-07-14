//
//  Cache.swift
//  SwiftFest
//
//  Created by Matthew Dias on 6/30/19.
//  Copyright © 2019 Sean Olszewski. All rights reserved.
//

import Foundation

struct Cache {
    
    private(set) var fileManager: FileManager
    private(set) var path: String
    
    init(fileManager: FileManager = FileManager.default,
         path: String = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String)) {
        self.fileManager = fileManager
        self.path = path
    }
    
    func save(response data: Data, to fileName: String) {
        if !fileManager.fileExists(atPath: path) {
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        
        guard let url = NSURL(string: path)?.appendingPathComponent(fileName) else { return }
        
        print("saving to: \(url.absoluteString)")
        
        let urlString: String = url.absoluteString
        fileManager.createFile(atPath: urlString, contents: data, attributes: nil)
    }
    
    func getFile(named name: String) -> Data? {
        let url = URL(fileURLWithPath: path).appendingPathComponent(name)
        if fileManager.fileExists(atPath: url.absoluteString) {
            let data = try? Data(contentsOf: url)
            return data
        } else {
            return nil
        }
    }
    
    func deleteFile(named name: String) {
        let cachedFilesPath = (path as NSString).appendingPathComponent(name)
        
        if fileManager.fileExists(atPath: cachedFilesPath) {
            try? fileManager.removeItem(atPath: cachedFilesPath)
        }
    }
}
