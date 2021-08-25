//
//  PatternOneViewModel.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import UIKit

class PatternOneViewModel {
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
        print("Deinit in Pattern One View Model!!")
    }
    
    func setTextField(textField: UITextField) {
        guard let text = textField.text else {
            self.update()
            return
        }
        if textField.tag == 10 {
            self.fileModel.setName(text)
        } else if textField.tag == 20 {
            if !text.isEmpty {
                self.fileModel.setPath(URL(string: text))
            } else {
                self.fileModel.setPath(nil)
            }
        }
        self.update()
    }
}
extension PatternOneViewModel {
    func configure(_ view: DefaultView) {
        self.view = view
        view.textFieldName.text = self.name
        view.textFieldURL.text = self.url?.absoluteString ?? ""
        self.update()
    }
    private func update() {
        /*
        var text = name
        if let url = self.url {
            text += " " + url.absoluteString
        }
        view?.textLabel.text = text
        
        if let pathText = view?.textField.text, !pathText.isEmpty {
            self.fileModel.setPath(URL(string: pathText))
        }
        */
        var text = name
        if let url = self.url {
            text += " " + url.absoluteString
        }
        if text.isEmpty {
            text = "Please Enter Name or url"
        }
        view?.textLabel.text = text
    }
}
