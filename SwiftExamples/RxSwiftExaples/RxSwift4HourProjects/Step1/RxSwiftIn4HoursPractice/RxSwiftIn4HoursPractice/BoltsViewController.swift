//
//  BoltsViewController.swift
//  RxSwiftIn4HoursPractice
//
//  Created by Dannian Park on 2021/06/25.
//

import UIKit

import BoltsSwift

class BoltsViewController: UIViewController {
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
        NSLog("Deinit in Bolts View Controller")
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var countLabel: UILabel!
    
    // MARK: - IBAction
    
    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil
        boltsLoadImage(from: LARGER_IMAGE_URL)
            .continueWith { task in
                DispatchQueue.main.async {
                    let image = task.result
                    self.imageView.image = image
                }
            }
    }
    
    // MARK: - Bolts
    
    func boltsLoadImage(from imageURL: String) -> Task<UIImage> {
        let taskCompletionSourse = TaskCompletionSource<UIImage>()
        asyncLoadImage(from: imageURL) { image in
            guard let image = image else {
                taskCompletionSourse.cancel()
                return
            }
            taskCompletionSourse.set(result: image)
        }
        return taskCompletionSourse.task
    }
}
