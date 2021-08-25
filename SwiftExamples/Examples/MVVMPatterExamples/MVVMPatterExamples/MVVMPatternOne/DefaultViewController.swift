//
//  DefaultViewController.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import UIKit

class DefaultViewController: UIViewController {
    var viewModel: DefaultViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultView = DefaultView()
        defaultView.textField.delegate = self
        defaultView.textField.addTarget(self, action: #selector(self.updateWhenChangeText(_:)), for: .editingChanged)
        
        let viewModel = DefaultViewModel()
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
        print("Deinit in Default View Controller!!")
    }
    
}

extension DefaultViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewModel.setTextField(text: textField.text ?? "")
    }
    
    @objc private func updateWhenChangeText(_ textField: UITextField) {
        let text = textField.text ?? ""
        self.viewModel.setTextField(text: text)
    }
}


class DefaultView: UIView {
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    let textField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .black
        tf.backgroundColor = .brown
        return tf
    }()
    
    let btn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("DONE?", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("Deinit in Default View!!")
    }
    
    private func setView() {
        self.backgroundColor = .white
        
        self.addSubview(textLabel)
        self.addSubview(textField)
        self.addSubview(btn)
        
        textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        btn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        btn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btn.addTarget(self, action: #selector(actionBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func actionBtn(_ sender: UIButton) {
        self.endEditing(true)
    }
}

