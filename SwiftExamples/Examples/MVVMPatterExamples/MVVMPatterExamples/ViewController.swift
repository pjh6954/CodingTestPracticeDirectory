//
//  ViewController.swift
//  MVVMPatterExamples
//
//  Created by Dannian Park on 2021/08/25.
//

import UIKit

class ViewController: UIViewController {
    let btnPatternOne : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Pattern One", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.addSubview(btnPatternOne)
        btnPatternOne.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnPatternOne.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        btnPatternOne.addTarget(self, action: #selector(self.actionBtnPatternOne(_:)), for: .touchUpInside)
    }
    
    @objc private func actionBtnPatternOne(_ sender: UIButton) {
        let vc = DefaultViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

