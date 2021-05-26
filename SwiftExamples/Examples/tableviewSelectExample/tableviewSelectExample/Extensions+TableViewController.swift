//
//  Extensions+TableViewController.swift
//  tableviewSelectExample
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

extension UIResponder {
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewController {
    
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }
    var indexPath: IndexPath? {
        guard let _indexPath = self.tableView?.indexPath(for: self) else {return nil}
        return _indexPath
        
    }
}

