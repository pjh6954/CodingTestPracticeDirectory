//
//  DefaultViewModel.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import Foundation

class DefaultViewModel {
    private let fileModel: FileModel
    private var view: DefaultView?
    
    var name: String {
        return fileModel.name
    }
    
    var url: URL? {
        return fileModel.path
    }
    
    init() {
        self.fileModel = FileModel()
        self.fileModel.setName("TEST NAME")
    }
    
    deinit {
        print("Deinit in Default View Model!!")
    }
    
    func setTextField(text: String) {
        if !text.isEmpty {
            self.fileModel.setPath(URL(string: text))
        } else {
            self.fileModel.setPath(nil)
        }
        self.update()
    }
}
extension DefaultViewModel {
    func configure(_ view: DefaultView) {
        self.view = view
        self.update()
    }
    private func update() {
        var text = name
        if let url = self.url {
            text += " " + url.absoluteString
        }
        view?.textLabel.text = text
        
        if let pathText = view?.textField.text, !pathText.isEmpty {
            self.fileModel.setPath(URL(string: pathText))
        }
    }
}
