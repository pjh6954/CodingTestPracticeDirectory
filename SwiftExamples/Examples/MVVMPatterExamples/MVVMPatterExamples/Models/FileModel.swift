//
//  FileModel.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import Foundation

class FileModel {
    private var nameValue : String = ""
    var name : String {
        return nameValue
    }
    private var pathValue : URL?
    var path : URL? {
        return pathValue
    }
    init() {
        
    }
    
    init(name: String, path: URL?) {
        self.nameValue = name
        self.pathValue = path
    }
    
    public func setPath(_ value : URL?) {
        self.pathValue = value
    }
    
    public func setName(_ value: String) {
        self.nameValue = value
    }
}
