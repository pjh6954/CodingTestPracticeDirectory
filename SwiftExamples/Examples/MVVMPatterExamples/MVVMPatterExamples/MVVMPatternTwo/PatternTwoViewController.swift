//
//  PatternTwoViewController.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import UIKit

class PatternTwoViewController: UIViewController {
    var viewModel : PatternTwoViewModel!
    var defaultView: DefaultView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.bindingViewModel()
    }
    
    deinit {
        print("Deinit in Pattern Two View Controller")
    }
    
    private func setView() {
        let defaultView = DefaultView()
        defaultView.textFieldURL.delegate = self
        defaultView.textFieldURL.addTarget(self, action: #selector(self.updateWhenChangeText(_:)), for: .editingChanged)
        
        defaultView.textFieldName.delegate = self
        defaultView.textFieldName.addTarget(self, action: #selector(self.updateWhenChangeText(_:)), for: .editingChanged)
        
        let viewModel = PatternTwoViewModel()
        self.viewModel = viewModel
        
        defaultView.textFieldName.text = self.viewModel.name
        defaultView.textFieldURL.text = self.viewModel.url?.absoluteString ?? ""
        
        self.view.addSubview(defaultView)
        defaultView.translatesAutoresizingMaskIntoConstraints = false
        defaultView.backgroundColor = .yellow
        
        let layoutGuide = self.view.safeAreaLayoutGuide
        defaultView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        defaultView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        defaultView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        defaultView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        
        self.defaultView = defaultView
    }
    
    private func bindingViewModel() {
        guard let vm = self.viewModel else { return }
        vm.update = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.updateView()
        }
        self.updateView()
    }
    
    private func updateView() {
        var text = self.viewModel.name
        if let url = self.viewModel.url {
            text += " " + url.absoluteString
        }
        if text.isEmpty {
            text = "Please Enter Name or url"
        }
        self.defaultView.textLabel.text = text
    }
}

extension PatternTwoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewModel.setTextField(textField: textField)
    }
    
    @objc private func updateWhenChangeText(_ textField: UITextField) {
        self.viewModel.setTextField(textField: textField)
    }
}

