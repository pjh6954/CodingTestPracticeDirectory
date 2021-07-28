//
//  ViewController.swift
//  WKWebviewTestApp
//
//  Created by Dannian Park on 2021/07/28.
//

import UIKit

class ViewController: UIViewController {
    private let urlList : [String] = ["https://m.daum.net", "https://m.naver.com"]
    @IBOutlet weak var btnContainer: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setDefaultView()
    }
    private func setDefaultView() {
        self.view.backgroundColor = .yellow
        
        let first = self.createBtn(#selector(self.actionConstSuperViewMove(_:)))
        first.setTitle("Constraint Super View", for: .normal)
        
        let second = self.createBtn(#selector(self.actionConstSafeViewMove(_:)))
        second.setTitle("Constraint Safe Area", for: .normal)
        
        guard let navi = self.navigationController else {
            return
        }
        let bar = navi.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = .clear
    }
    private func createBtn(_ method : Selector) -> UIButton {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        self.btnContainer.addArrangedSubview(btn)
        btn.addTarget(self, action: method, for: .touchUpInside)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }
    
    @objc private func actionConstSuperViewMove(_ sender: UIButton) {
        guard let navi = self.navigationController, let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewControllerOne") as? WebViewControllerOne else {
            return
        }
        vc.urlList = self.urlList
        navi.pushViewController(vc, animated: true)
    }
    
    @objc private func actionConstSafeViewMove(_ sender: UIButton) {
        guard let navi = self.navigationController, let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewControllerTwo") as? WebViewControllerTwo else {
            return
        }
        vc.urlList = self.urlList
        navi.pushViewController(vc, animated: true)
    }
}
