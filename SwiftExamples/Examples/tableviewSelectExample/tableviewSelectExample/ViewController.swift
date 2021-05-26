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
    private var currentOrangeSelectIndex : IndexPath?
    
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
        } else if let indexOrange = self.currentOrangeSelectIndex, indexOrange == indexPath {
            cell.backgroundColor = .orange
        } else {
            cell.backgroundColor = .white
        }
        return cell
    }
    
    
}

extension ViewController: TableViewCellDelegate {
    func selectedWithIndex(_ index: IndexPath, type: selectType) {
        var reloadIndex = [index]
        
        if let indexPath = self.currentSelectIndex {
            reloadIndex.append(indexPath)
        }
        if let indexPath = self.currentOrangeSelectIndex {
            reloadIndex.append(indexPath)
        }
        // 아래 코드에서 if문 안에 if문이 있는 이유는
        // 1번 셀에서 green 선택 후 orange를 선택하고, 그 후 2번 셀을 orange를 선택하는 경우 1번 셀이 green이 표시가 되는 경우를 없에기 위함.
        if type == .green {
            self.currentSelectIndex = index
            if self.currentOrangeSelectIndex == index {
                self.currentOrangeSelectIndex = nil
            }
        }
        else if type == .orange {
            self.currentOrangeSelectIndex = index
            if self.currentSelectIndex == index {
                self.currentSelectIndex = nil
            }
        }
        self.tableView.reloadRows(at: reloadIndex, with: .none)
    }
}
