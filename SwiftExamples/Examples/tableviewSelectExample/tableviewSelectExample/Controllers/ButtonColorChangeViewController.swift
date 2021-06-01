//
//  ButtonColorChangeViewController.swift
//  tableviewSelectExample
//
//  Created by Dannian Park on 2021/05/27.
//

import UIKit

class ButtonColorChangeViewController : UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    private let defaultColor : UIColor = .white // 기본 cell의 백그라운드의 색상
    private let selectedBgColor : UIColor = .magenta
    
    private let btnDefaultColor : UIColor = .white // 기본 button의 색상 정의
    
    
    private var data : TableBtnAndBGColorDataModels! {
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
        tableview.register(cellNib, forCellReuseIdentifier: cellNibName)
        tableview.delegate = self
        tableview.dataSource = self
    }
    private func dataMaking() {
        data = .init(makeCounter: 60, defaultColor: self.defaultColor, btnDefaultColor: self.btnDefaultColor)
    }
    private func updateTableData() {
        // print("UPDATE!")
    }
}

extension ButtonColorChangeViewController: UITableViewDelegate, UITableViewDataSource {
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
        var btnNum = 0
        if let obj = self.data.selectedCellAndBtn, obj.index == indexPath {
            btnNum = obj.btnNum
        }
        cell.setData(self.data.datas[indexPath.item], colorBtnNum: btnNum)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell 선택 시
        let updateCell = self.data.updateSelectedIndex(index: indexPath, withColor: self.selectedBgColor)
        self.tableview.reloadRows(at: updateCell, with: .none)
    }
}


extension ButtonColorChangeViewController : TableViewCellDelegate {
    func selectedBtnBGChange(_ index: IndexPath, btnNum: Int) {
        var reloadCell = [index]
        if let obj = self.data.selectedCellAndBtn {
            reloadCell.append(obj.index)
        }
        self.data.selectedCellAndBtn = (index, btnNum)
        self.tableview.reloadRows(at: reloadCell, with: .none)
        // self.tableview.reloadData() // 모든 cell 데이터 일괄 갱신.
    }
}
