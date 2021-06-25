//
//  AsyncViewController.swift
//  RxSwiftIn4HoursPractice
//
//  Created by Dannian Park on 2021/06/25.
//

import UIKit

class AsyncViewController: UIViewController {
    // MARK: - Field
    
    var counter: Int = 0
    var IMAGE_URL = "https://picsum.photos/1280/720/?random"
    
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        //self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
        //}
        timer?.fire()
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            // deinit을 위해서 객체를 해제
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    deinit {
        NSLog("Deinit in Async View Controller")
    }
    
    @objc private func timerAction() {
        self.counter += 1
        self.countLabel.text = "\(self.counter)"
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var countLabel: UILabel!
    
    // MARK: - IBAction
    
    @IBAction func onLoadSync(_ sender: Any) {
        let image = loadImage(from: IMAGE_URL)
        imageView.image = image
    }
    
    @IBAction func onLoadAsync(_ sender: Any) {
        DispatchQueue.global().async {
            let image = self.loadImage(from: self.IMAGE_URL)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    private func loadImage(from imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }

        let image = UIImage(data: data)
        return image
    }
}
