//
//  ViewController.swift
//  TheoryStudyProject
//
//  Created by Dannian Park on 2021/09/01.
//

import UIKit

class ViewController: UIViewController {
    private let testView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    // MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("\(#fileID)::\(#function)")
        self.commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#fileID)::\(#function)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#fileID)::\(#function)")
        self.drawLayerInBackgroundTest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(#fileID)::\(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(#fileID)::\(#function)")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        print("\(#fileID)::\(#function)")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        print("\(#fileID)::\(#function)")
    }
    
    // My Functions
    private func commonInit() {
        print("\(#fileID)::\(#function)")
        self.view.addSubview(self.testView)
        NSLayoutConstraint.activate([
            .init(item: testView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: testView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0),
            .init(item: testView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100),
            .init(item: testView, attribute: .width, relatedBy: .equal, toItem: testView, attribute: .height, multiplier: 1.5, constant: 0)
        ])
    }
    
    private func drawLayerInBackgroundTest() {
        print("\(#fileID)::\(#function)")
        func drawing() {
            self.testView.layer.borderWidth = 2
            self.testView.layer.borderColor = UIColor.darkGray.cgColor
        }
        //DispatchQueue.global(qos: .background).async { drawing() } // UIView.layer must be used from main thread only
        //DispatchQueue.global(qos: .background).sync { drawing() } // 잘 나오는데, 그 이유는 sync가 결국 메인 thread에서 돌기 때문...
        
        //DispatchQueue.global(qos: .default).async { drawing() } // UIView.layer must be used from main thread only
        //DispatchQueue.global(qos: .default).sync { drawing() }
        
        //DispatchQueue.global(qos: .unspecified).async { drawing() } // UIView.layer must be used from main thread only
        //DispatchQueue.global(qos: .unspecified).sync { drawing() }
        
        //DispatchQueue.global(qos: .userInitiated).async { drawing() } // UIView.layer must be used from main thread only
        //DispatchQueue.global(qos: .userInitiated).sync { drawing() }
        
        //DispatchQueue.global(qos: .userInteractive).async { drawing() } // UIView.layer must be used from main thread only
        //DispatchQueue.global(qos: .userInteractive).sync { drawing() }
        
        //DispatchQueue.global(qos: .utility).async { drawing() } // UIView.layer must be used from main thread only
        //DispatchQueue.global(qos: .utility).sync { drawing() }
        
        // 정상적인접근
        //DispatchQueue.main.async { drawing() }
        
        
        let tesqueue = DispatchQueue(label: "tesqueue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit)
        //let tesqueue = DispatchQueue(label: "tesqueue", qos: .default, autoreleaseFrequency: .inherit)
        //tesqueue.async { drawing() }
        tesqueue.sync { drawing() }
        // sync가 되면 무소건 thread1에서 처리가 되는 것을 확인함. 이런 이유로 인해 disqueue.global() 등 여러 방법을 써도 sync를 호출하면 dispatchqueue.main.async와 동일한 결과를 도출 하는 것으로 확인.
    }
}

