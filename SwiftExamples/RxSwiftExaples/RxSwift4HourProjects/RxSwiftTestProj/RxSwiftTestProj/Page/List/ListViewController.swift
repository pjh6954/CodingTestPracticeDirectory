//
//  ListViewController.swift
//  RxSwiftTestProj
//
//  Created by Dannian Park on 2021/06/24.
//

import UIKit

import RxSwift
import RxCocoa
import CWUtils
import RxOptional

class ListViewController : UIViewController {
    
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindView()
    }
    
    private func setupView() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
        
        title = "Memebers"
        view.backgroundColor = .white
        
        tableView = createView(UITableView(), parent: view, setting: { v in
            v.rowHeight = UITableView.automaticDimension
            v.register(cellType: MemberCell.self)
        }, constraint: { m in
            m.edges.equalToSuperview()
        })
        
    }
    
    private func bindView() {
        
    }
}
