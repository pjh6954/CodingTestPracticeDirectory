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
        
        // ???????????? ???????????? ????????? ??????
        // labelOne.text = "asdl"
        // labelTwo.text = "TWOas"
        // labelOne.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        // labelTwo.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
        
        // labelOne.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        // labelTwo.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        
        // labelOne.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
        // labelTwo.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
        
        // ????????? ???????????? ????????? ??????
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
    // MARK: - Thread??? ????????? CALayer ?????????
    private func drawLayerInBackgroundTest() {
        print("\(#fileID)::\(#function)")
        func drawing() {
            self.testView.layer.borderWidth = 2
            self.testView.layer.borderColor = UIColor.darkGray.cgColor
        }
        //DispatchQueue.global(qos: .background).async { drawing() } // UIView.layer must be used from main thread only
        //DispatchQueue.global(qos: .background).sync { drawing() } // ??? ????????????, ??? ????????? sync??? ?????? ?????? thread?????? ?????? ??????...
        
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
        
        // ??????????????????
        //DispatchQueue.main.async { drawing() }
        
        
        let tesqueue = DispatchQueue(label: "tesqueue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit)
        //let tesqueue = DispatchQueue(label: "tesqueue", qos: .default, autoreleaseFrequency: .inherit)
        //tesqueue.async { drawing() }
        tesqueue.sync { drawing() }
        // sync??? ?????? ????????? thread1?????? ????????? ?????? ?????? ?????????. ?????? ????????? ?????? disqueue.global() ??? ?????? ????????? ?????? sync??? ???????????? dispatchqueue.main.async??? ????????? ????????? ?????? ?????? ????????? ??????.
    }
    
    // MARK: - ??? ?????????.sync??? ???????????? ?????? ????????????
    private func multipleThreadWithSync() {
        func drawingColorSwitching(_ view: UIView, color: UIColor) {
            view.layer.borderWidth = 4
            view.layer.borderColor = view.backgroundColor?.cgColor
            view.backgroundColor = color
        }
        
        /// ??? ????????? ?????? sync??????, thread1?????? ?????? ???????????? ????????? ???????????? ???????????? ??????.
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
        // ???????????? ?????? ????????? ?????? ??? ??? ?????? ???????????? ??? ??????(?????? main?????????) ???????????? qos??? ?????? ?????? ????????? ???????????? ?????????.(?????????)
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

