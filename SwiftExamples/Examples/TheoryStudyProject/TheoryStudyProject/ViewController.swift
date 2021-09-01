//
//  ViewController.swift
//  TheoryStudyProject
//
//  Created by Dannian Park on 2021/09/01.
//

import UIKit

class ViewController: UIViewController {
    private let stv : UIStackView = {
        let stv = UIStackView()
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.spacing = 10
        stv.axis = .vertical
        return stv
    }()
    private let testView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    private let testSecondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    private let stvLabel: UIStackView = {
        let stv = UIStackView()
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.axis = .horizontal
        stv.spacing = 0
        stv.distribution = .fillProportionally
        return stv
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
        // self.drawLayerInBackgroundTest()
        // self.multipleThreadWithSync()
        self.drawingLabelContainer()
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
        // self.drawingOneView()
        // self.drawingTwoView()
    }
    
    
}
// MARK: - Drawing View
extension ViewController {
    private func drawingOneView() {
        // center only one view display
        self.view.addSubview(self.testView)
        NSLayoutConstraint.activate([
            .init(item: testView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: testView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0),
            .init(item: testView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100),
            .init(item: testView, attribute: .width, relatedBy: .equal, toItem: testView, attribute: .height, multiplier: 1.5, constant: 0)
        ])
    }
    private func drawingTwoView() {
        // uiview double display
        self.view.addSubview(self.stv)
        self.stv.distribution = .fillEqually
        NSLayoutConstraint.activate([
            .init(item: self.stv, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.7, constant: 0),
            .init(item: self.stv, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.5, constant: 0),
            .init(item: self.stv, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: self.stv, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        self.stv.addArrangedSubview(self.testView)
        self.stv.addArrangedSubview(self.testSecondView)
    }
    private func drawingLabelContainer() {
        self.view.addSubview(self.stvLabel)
        NSLayoutConstraint.activate([
            .init(item: stvLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            .init(item: stvLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0),
            .init(item: stvLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        ])
        let labelOne = UILabel()
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        labelOne.font = .systemFont(ofSize: 30, weight: .bold)
        labelOne.textColor = .red
        labelOne.backgroundColor = .gray
        
        let labelTwo = UILabel()
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.font = .systemFont(ofSize: 30, weight: .bold)
        labelTwo.textColor = .blue
        labelTwo.backgroundColor = .lightGray
        
        // 작아지는 우선순위 테스트 시작
        // labelOne.text = "asdl"
        // labelTwo.text = "TWOas"
        // labelOne.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        // labelTwo.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
        
        // labelOne.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        // labelTwo.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        
        // labelOne.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
        // labelTwo.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        
        // 커지는 우선순위 테스트 시작
        labelOne.text = "testtest-red-bigger?test"
        labelTwo.text = "BLUEE TESTTEST BIGGER TEST"
        // labelOne.setContentCompressionResistancePriority(.init(200), for: .horizontal)
        // labelTwo.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        
        // labelOne.setContentCompressionResistancePriority(.init(200), for: .horizontal)
        // labelTwo.setContentCompressionResistancePriority(.init(200), for: .horizontal)
        
        labelOne.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        labelTwo.setContentCompressionResistancePriority(.init(200), for: .horizontal)
        
        self.stvLabel.addArrangedSubview(labelOne)
        self.stvLabel.addArrangedSubview(labelTwo)
    }
}

extension ViewController {
    // MARK: - Thread와 관련된 CALayer 테스트
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
    
    // MARK: - 각 쓰레드.sync와 우선순위 간의 차이여부
    private func multipleThreadWithSync() {
        func drawingColorSwitching(_ view: UIView, color: UIColor) {
            view.layer.borderWidth = 4
            view.layer.borderColor = view.backgroundColor?.cgColor
            view.backgroundColor = color
        }
        
        /// 이 경우는 결국 sync이고, thread1에서 모두 처리하기 때문에 순서대로 동작하게 된다.
        /*
        DispatchQueue.global(qos: .background).sync {
            drawingColorSwitching(self.testView, color: .yellow)
            drawingColorSwitching(self.testView, color: .purple)
            drawingColorSwitching(self.testView, color: .black)
            drawingColorSwitching(self.testView, color: .magenta)
            drawingColorSwitching(self.testView, color: .blue)
        }
        DispatchQueue.global(qos: .userInteractive).sync {
            drawingColorSwitching(self.testSecondView, color: .red)
            drawingColorSwitching(self.testSecondView, color: .orange)
            drawingColorSwitching(self.testSecondView, color: .darkGray)
            drawingColorSwitching(self.testSecondView, color: .gray)
            drawingColorSwitching(self.testSecondView, color: .green)
        }
        */
        // 초반에는 먼저 시작한 쪽이 좀 더 많이 수행되는 듯 하나(특히 main에서는) 나중되면 qos에 따라 처리 순서가 달라지기 시작함.(대체로)
        DispatchQueue.global(qos: .background).async {
            
            DispatchQueue.main.async {
                print("Background - 1")
                drawingColorSwitching(self.testView, color: .yellow)
            }
            //sleep(1)
            DispatchQueue.main.async {
                print("Background - 2")
                drawingColorSwitching(self.testView, color: .purple)
            }
            //sleep(1)
            DispatchQueue.main.async {
                print("Background - 3")
                drawingColorSwitching(self.testView, color: .black)
            }
            //sleep(1)
            DispatchQueue.main.async {
                print("Background - 4")
                drawingColorSwitching(self.testView, color: .magenta)
            }
            //sleep(1)
            DispatchQueue.main.async {
                print("Background - 5")
                drawingColorSwitching(self.testView, color: .blue)
            }
            
            for i in 1 ... 10 {
                print("BACKGROUND FOR :: \(i)")
                defer {
                    print("DEFER ::: Background :: \(i)")
                }
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                print("UserInteractive - 1")
                drawingColorSwitching(self.testSecondView, color: .red)
            }
            //sleep(1)
            DispatchQueue.main.async {
                print("UserInteractive - 2")
                drawingColorSwitching(self.testSecondView, color: .orange)
            }
            //sleep(1)
            DispatchQueue.main.async {
                print("UserInteractive - 3")
                drawingColorSwitching(self.testSecondView, color: .darkGray)
            }
            //sleep(1)
            DispatchQueue.main.async {
                print("UserInteractive - 4")
                drawingColorSwitching(self.testSecondView, color: .gray)
            }
            //sleep(1)
            DispatchQueue.main.async {
                print("UserInteractive - 5")
                drawingColorSwitching(self.testSecondView, color: .green)
            }
            
            for i in 1 ... 10 {
                print("USERINTERACTIVE FOR :: \(i)")
                defer {
                    print("DEFER ::: UserInteractive :: \(i)")
                }
            }
        }
    }
}

