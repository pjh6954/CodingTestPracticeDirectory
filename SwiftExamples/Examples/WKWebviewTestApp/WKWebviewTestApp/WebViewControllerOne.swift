//
//  WebViewControllerOne.swift
//  WKWebviewTestApp
//
//  Created by Dannian Park on 2021/07/28.
//

import UIKit
import WebKit

class WebViewControllerOne: UIViewController {
    var urlList : [String] = []
    private var index : Int = 0
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNaviBar()
        self.loadPage()
    }
    private func setNaviBar() {
        let item = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
        self.navigationItem.rightBarButtonItem = item
        
    }
    private func loadPage() {
        guard index < urlList.count else { return }
        let str = urlList[index]
        guard let url = URL(string: str) else { return }
        self.webView.load(URLRequest(url: url))
    }
    
    @objc private func refreshAction() {
        guard !urlList.isEmpty else { return }
        if index + 1 >= urlList.count {
            index = 0
        } else {
            index += 1
        }
        loadPage()
    }
}
