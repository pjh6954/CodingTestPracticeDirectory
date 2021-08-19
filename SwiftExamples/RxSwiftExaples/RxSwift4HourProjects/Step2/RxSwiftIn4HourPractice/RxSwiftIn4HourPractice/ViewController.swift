//
//  ViewController.swift
//  RxSwiftIn4HourPractice
//
//  Created by Dannian Park on 2021/06/25.
//

import UIKit

import RxSwift

//just, from, map, filter
class ViewController: UITableViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exJust1() {
        // data 직접 제공하기 위해서 just사용. 해당 데이터를 그대로 다음 method에 전달.
        Observable.just("Hello World")
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exJust2() {
        Observable.just(["Hello", "World"])
            //.subscribe(onNext: { arr in // 이 경우는 next의 경우만 값을 반환함. 즉 next이후 호출되는 complete는 반환이 안됨.
            //    print(arr)
            //})
            .subscribe { result in // 이 경우는 next, error, complete가 반환됨
                print("result:: \(result)")
                switch result {
                case let .next(arr):
                    print(arr)
                case let .error(err):
                    print("Error: \(err.localizedDescription)")
                case .completed:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func exFrom1() {
        Observable.from(["RxSwift", "In", "4", "Hours"]) // array에 있는 것을 각각 보내게 됨. == for 또는 forEach와 같은 역할
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)

    }
    
    @IBAction func exMap1() {
        Observable.just("Hello")
            .map { str in "\(str) RxSwift" } // hello가 그대로 내려 온 후 map에서 조합.(새로운 array생성. just였기 때문에 현재는 string 하나 뿐이어서 한 개만 출력이 된 상태.)
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exMap2() {
        Observable.from(["with", "곰튀김"]) // Stream
            .map { $0.count }
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exFilter() {
        Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            // filter에서 새로 array가 만들어진 후 다음 플로우로 가는 것이 아니라, 해당 필터에서 true인 경우 바로 다음(subscribe)로 진행이 된다.
            .filter({ value in
                print("Value : \(value)")
                return value % 2 == 0
            })
            //.filter { $0 % 2 == 0 }
            .subscribe(onNext: { n in
                print(n)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exMap3() {
        // map을 가장 많이 쓴다. 이해 필수.
        Observable.just("800x600")
            .map { $0.replacingOccurrences(of: "x", with: "/") } // replace : 800x600 -> 800/600
            .map { "https://picsum.photos/\($0)/?random" } // "https://picsum.photos/800/600/?random"
            .map { URL(string: $0) } // Optional(https://picsum.photos/800/600/?random)
            .filter { $0 != nil } // filter = 여기서는 check를 하게 됨. nil인 경우 내려가지 않는다.(false기 때문)
            .map { $0! } // 강제 unwrapping : (URL)https://picsum.photos/800/600/?random
            .map { try Data(contentsOf: $0) } // Data
            .map { UIImage(data: $0) } // UIImage?
            .subscribe(onNext: { image in
                self.imageView.image = image
            })
            .disposed(by: disposeBag)
    }
    
}

