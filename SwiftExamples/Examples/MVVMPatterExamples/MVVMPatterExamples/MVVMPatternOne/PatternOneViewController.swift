//
//  PatternOneViewController.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import UIKit

class PatternOneViewController: UIViewController {
    var viewModel: PatternOneViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultView = DefaultView()
        defaultView.textFieldURL.delegate = self
        defaultView.textFieldURL.addTarget(self, action: #selector(self.updateWhenChangeText(_:)), for: .editingChanged)
        
        defaultView.textFieldName.delegate = self
        defaultView.textFieldName.addTarget(self, action: #selector(self.updateWhenChangeText(_:)), for: .editingChanged)
        
        let viewModel = PatternOneViewModel()
        viewModel.configure(defaultView)
        
        self.viewModel = viewModel
        
        self.view.addSubview(defaultView)
        defaultView.translatesAutoresizingMaskIntoConstraints = false
        defaultView.backgroundColor = .green
        /*
        NSLayoutConstraint.activate([
            .init(item: defaultView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
            .init(item: defaultView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
            .init(item: defaultView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: defaultView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        */
        let layoutGuide = self.view.safeAreaLayoutGuide
        defaultView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        defaultView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        defaultView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        defaultView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        
    }
    
    deinit {
        print("Deinit in Pattern One View Controller!!")
    }
    
}

extension PatternOneViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewModel.setTextField(textField: textField)
    }
    
    @objc private func updateWhenChangeText(_ textField: UITextField) {
        self.viewModel.setTextField(textField: textField)
    }
}
