//
//  PatternTwoViewModel.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import UIKit
//modelName

protocol PatternTwoViewModelInput {
    func setTextField(textField: UITextField)
}
protocol PatternTwoViewModelOutput {
    var update: (() -> Void)? {get set}
}
protocol PatternTwoViewModelType {
    var inputs : PatternTwoViewModelInput {get}
    var outputs: PatternTwoViewModelOutput {get}
}

class PatternTwoViewModel : PatternTwoViewModelInput, PatternTwoViewModelOutput, PatternTwoViewModelType {
    
    private let fileModel : FileModel
    
    var name : String {
        return fileModel.name
    }
    
    var url : URL? {
        return fileModel.path
    }
    
    init() {
        self.fileModel = .init()
        self.fileModel.setName("TEST NAME Two")
    }
    
    deinit {
        print("Deinit in Pattern Two View Model")
    }
    
    // Input
    func setTextField(textField: UITextField) {
        guard let text = textField.text else { return }
        if textField.tag == 10 {
            self.fileModel.setName(text)
        } else if textField.tag == 20 {
            if !text.isEmpty {
                self.fileModel.setPath(URL(string: text))
            } else {
                self.fileModel.setPath(nil)
            }
        }
        self.update?()
    }
    
    // Output
    var update: (() -> Void)?
    
    var inputs : PatternTwoViewModelInput { return self }
    var outputs: PatternTwoViewModelOutput { return self }
    
}
