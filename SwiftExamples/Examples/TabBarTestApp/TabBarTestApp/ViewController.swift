//
//  ViewController.swift
//  TabBarTestApp
//
//  Created by Dannian Park on 2021/05/24.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModelBinding()
    }
    
    private func viewModelBinding() {
        self.viewModel.moveReturn = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            print("StrongSelf! : \(strongSelf)")
            guard let tabBarController = UIStoryboard(name: "TabBarViewController", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else {
                return
            }
            // tabBarController.modalPresentationStyle = .fullScreen // full screen으로 띄우고자 할 때
            strongSelf.present(tabBarController, animated: true) {
                
            }
        }
    }
    
    @IBAction func actionPresent(_ sender: UIButton) {
        viewModel.moveFunction()
    }
}

protocol viewModelProtocol {
    func moveFunction()
    var moveReturn: (() -> Void)? { get }
}

class ViewModel : viewModelProtocol {
    
    func moveFunction() {
        self.moveReturn?()
    }
    
    //output
    var moveReturn: (() -> Void)?
}
