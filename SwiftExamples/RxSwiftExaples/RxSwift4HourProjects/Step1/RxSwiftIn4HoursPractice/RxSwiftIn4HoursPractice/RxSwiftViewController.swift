//
//  RxSwiftViewController.swift
//  RxSwiftIn4HoursPractice
//
//  Created by Dannian Park on 2021/06/25.
//

import UIKit

import RxSwift

class RxSwiftViewController: UIViewController {
    // MARK: - Field
    
    var counter : Int = 0
    var timer : Timer?
    var disposableReturn : Disposable?
    var disposeBagReturn : DisposeBag = .init()
    
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
        NSLog("Deinit in RxSwift View Controller")
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var countLabel: UILabel!
    
    // MARK: - IBAction
    
    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil
        // Disposable : 말 그대로 취소 가능한. observe해둔 아이템을 취소하게 된다.
        // disposableReturn = rxswiftLoadImage(from: LARGER_IMAGE_URL)
        // dispose 관련
        // let disposable = rxswiftLoadImage(from: LARGER_IMAGE_URL) // disposeBagReturn에 insert시킬 켱우
        _ = rxswiftLoadImage(from: LARGER_IMAGE_URL) // disposeBagReturn에 굳이 insert할 필요 없게 만들 경우
            .observe(on: MainScheduler.instance)
            //.subscribe(<#T##on: (Event<UIImage?>) -> Void##(Event<UIImage?>) -> Void#>)
            .subscribe({ result in
                switch result {
                case let .next(image):
                    print("Next image : \(image?.debugDescription ?? "")")
                    self.imageView.image = image
                case let .error(err):
                    print(err.localizedDescription)
                case .completed:
                    print("Completed")
                    break
                }
                
            })
            .disposed(by: disposeBagReturn) // 이 경우 굳이 return 되는 것을 받아서 넣을 필요가 없어진다.
        // disposeBagReturn.insert(disposable)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        // disposableReturn?.dispose() // 개별 액션에 대해서 없엠
        disposeBagReturn = DisposeBag() // 등록된 액션을 모두 없에기 때문에 각각을 dispose시키는 것과 동일
    }
    
    // MARK: - RxSwift
    
    func rxswiftLoadImage(from imageURL: String) -> Observable<UIImage?> {
        return Observable.create { seal in
            asyncLoadImage(from: imageURL) { image in
                seal.onNext(image)
                seal.onCompleted()
            }
            return Disposables.create()
        }
    }
}
