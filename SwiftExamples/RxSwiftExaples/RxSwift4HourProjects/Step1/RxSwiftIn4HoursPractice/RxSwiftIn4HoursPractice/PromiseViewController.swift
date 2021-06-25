//
//  PromiseViewController.swift
//  RxSwiftIn4HoursPractice
//
//  Created by Dannian Park on 2021/06/25.
//

import UIKit

import PromiseKit

class PromiseViewController: UIViewController {
    // MARK: - Field
    
    var counter: Int = 0
    
    var timer : Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        })
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    deinit {
        NSLog("Deinit in Promise View Controller")
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var countLabel: UILabel!
    
    // MARK: - IBAction
    
    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil
        promiseLoadImage(from: LARGER_IMAGE_URL)
            .done { image in
                self.imageView.image = image
            }.catch { error in
                print(error.localizedDescription)
            }
    }
    
    // MARK: - PromiseKit
    
    func promiseLoadImage(from imageURL : String) -> Promise<UIImage?> {
        //Promise<UIImage?>(resolver: <#T##(Resolver<UIImage?>) throws -> Void#>)
        return Promise<UIImage?> { seal in
            asyncLoadImage(from: imageURL) { image in
                seal.fulfill(image)
            }
        }
    }
}
