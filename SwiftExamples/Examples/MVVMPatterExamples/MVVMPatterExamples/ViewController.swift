//
//  ViewController.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import UIKit

class ViewController: UIViewController {
    let stv : UIStackView = {
        let stv = UIStackView()
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.axis = .horizontal
        stv.spacing = 10
        return stv
    }()
    
    let btnPatternOne : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Pattern One", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    
    let btnPatternTwo : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Pattern Two", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.view.addSubview(stv)
        stv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stv.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        stv.addArrangedSubview(btnPatternOne)
        btnPatternOne.addTarget(self, action: #selector(self.actionBtnPatternOne(_:)), for: .touchUpInside)
        
        stv.addArrangedSubview(btnPatternTwo)
        btnPatternTwo.addTarget(self, action: #selector(self.actionBtnPatternTwo(_:)), for: .touchUpInside)
    }
    
    @objc private func actionBtnPatternOne(_ sender: UIButton) {
        let vc = PatternOneViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func actionBtnPatternTwo(_ sender: UIButton) {
        let vc = PatternTwoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

