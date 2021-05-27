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


// 각 셀의 background color 및 각 button의 색상을 변경해주기 위함.
public struct TableBtnAndBGColorDataModels {
    /**
     cell을 터치 했을 때 selected된 것을 저장하기 위한 변수. get only.
     */
    var selectedCellIndex : IndexPath? {
        get {
            return _currentSelectedCellIndex
        }
    }
    private var _currentSelectedCellIndex : IndexPath?
    /**
     button을 눌렀을 때, 해당하는 index와 몇 번째 button인지 저장하기 위한 변수
     */
    var selectedCellAndBtn : (index: IndexPath, btnNum: Int)?
    
    /** cell을 구성하기 위한 데이터 모델들의 array */
    var datas : [TableBtnAndBGColorData] = []
    init(makeCounter : Int, defaultColor : UIColor = .white, btnDefaultColor : UIColor = .white) {
        for _ in 0 ..< makeCounter {
            self.datas.append(.init(defaultColor: defaultColor, btnDefaultColor: btnDefaultColor))
        }
    }
    /** cell의 백그라운드를 변경하기 위해  selectedCellIndex를 update 해주는 함수*/
    public mutating func updateSelectedIndex(index: IndexPath, withColor: UIColor = .cyan) -> [IndexPath]{
        var returnIndex : [IndexPath] = [index]
        if let current = _currentSelectedCellIndex {
            returnIndex.append(current)
            self.datas[current.item].updateBG(nil)
        }
        self.datas[index.item].updateBG(withColor)
        self._currentSelectedCellIndex = index
        return returnIndex
    }
}
public struct TableBtnAndBGColorData {
    /** cell의 background color를 갖고오기 위한 변수 */
    public var backgroundColor: UIColor {
        get {
            return bgColor ?? defaultColor
        }
    }
    private var defaultColor : UIColor
    private var bgColor : UIColor?
    
    public var btnColor : UIColor {
        get {
            return btnDefaultColor
        }
    }
    private var btnDefaultColor : UIColor
    
    init(defaultColor : UIColor, btnDefaultColor : UIColor) {
        self.defaultColor = defaultColor
        self.btnDefaultColor = btnDefaultColor
    }
    fileprivate mutating func updateBG(_ color: UIColor?) {
        self.bgColor = color
    }
}
