//
//  ViewController.swift
//  tableviewSelectExample
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var currentSelectIndex : IndexPath?
    
    private let cellNibName = String(describing: TableViewCell.self) // "TableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        config()
    }
    
    private func config() {
        let cellNib = UINib(nibName: cellNibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellNibName)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellNibName, for: indexPath) as? TableViewCell else {
            return TableViewCell()
        }
        cell.delegate = self
        if let index = self.currentSelectIndex, index == indexPath {
            cell.backgroundColor = .green
        }else{
            cell.backgroundColor = .white
        }
        return cell
    }
    
    
}

extension ViewController: TableViewCellDelegate {
    func selectedWithIndex(_ index: IndexPath) {
        var reloadIndex = [index]
        if let indexPath = self.currentSelectIndex {
            reloadIndex.append(indexPath)
        }
        self.currentSelectIndex = index
        self.tableView.reloadRows(at: reloadIndex, with: .none)
    }
}
