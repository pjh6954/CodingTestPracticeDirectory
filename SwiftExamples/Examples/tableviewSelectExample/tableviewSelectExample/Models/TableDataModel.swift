//
//  TableDataModel.swift
//  tableviewSelectExample
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

public struct TableCellDataModels {
    var currentColors : [UIColor: IndexPath] = [:]
    var datas : [TableCellDataModel] = []
    init(makeCounter : Int, defaultColor : UIColor = .white) {
        for _ in 0 ..< makeCounter {
            self.datas.append(.init(defaultColor: defaultColor))
        }
    }
    
    public mutating func updateDatas(indexPath : IndexPath, color: UIColor) -> IndexPath? {
        var returnIndex : IndexPath? = nil
        if currentColors.keys.contains(color) {
            let beforeIndex = currentColors[color]!
            datas[beforeIndex.item].updateColor()
            returnIndex = beforeIndex
        }
        currentColors[color] = indexPath
        datas[indexPath.item].updateColor(color)
        return returnIndex
    }
}

public struct TableCellDataModel {
    private var defaultColor : UIColor
    private var color : UIColor?
    public var backgroundColor: UIColor {
        get {
            return color ?? defaultColor
        }
    }
    init(defaultColor : UIColor) {
        self.defaultColor = defaultColor
    }
    public mutating func updateColor(_ updateColor: UIColor? = nil) {
        self.color = updateColor
    }
}
