//
//  ModelViewController.swift
//  tableviewSelectExample
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

class ModelViewController : UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let defaultColor : UIColor = .white
    
    private var data : TableCellDataModels! {
        didSet {
            updateTableData()
        }
    }
    
    private let cellNibName = String(describing: TableViewCell.self) // "TableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.dataMaking()
    }
    
    private func config() {
        let cellNib = UINib(nibName: cellNibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellNibName)
    }
    private func dataMaking() {
        data = .init(makeCounter: 10, defaultColor: .white)
    }
    private func updateTableData() {
        print("UPDATE!")
    }
}

extension ModelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellNibName, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else {
            return
        }
        cell.delegate = self
        cell.setData(self.data.datas[indexPath.item])
    }
}

extension ModelViewController: TableViewCellDelegate {
    func selectedWithIndex(_ index: IndexPath, type: selectType) {
        var reloadIndex = [index]
        
        let returnIndex = self.data.updateDatas(indexPath: index, color: (type == .green ? .green : .orange))
        
        if returnIndex != nil {
            reloadIndex.append(returnIndex!)
        }
        
        self.tableView.reloadRows(at: reloadIndex, with: .none)
    }
}
