//
//  DefaultView.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import UIKit

class DefaultView: UIView {
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    let stv : UIStackView = {
        let stv = UIStackView()
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.axis = .vertical
        stv.spacing = 20
        return stv
    }()
    
    let textFieldName : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .black
        tf.backgroundColor = .brown
        tf.placeholder = "Name Input"
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.tag = 10
        return tf
    }()
    
    let textFieldURL : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .black
        tf.backgroundColor = .brown
        tf.placeholder = "URL Input"
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.tag = 20
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
        self.addSubview(stv)
        self.addSubview(btn)
        
        stv.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stv.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stv.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        stv.addArrangedSubview(self.textFieldName)
        stv.addArrangedSubview(self.textFieldURL)
        
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
