//
//  Models.swift
//  PickerViewExample
//
//  Created by Dannian Park on 2021/05/27.
//

import UIKit

struct locationsModel {
    var datas : [location] {
        get {
            return _datas
        }
    }
    private var _datas : [location] = []
    init(datas : [location]) {
        self._datas = datas
    }
    mutating func updateData(insert : location) {
        _datas.append(insert)
    }
    
    func getData(componentIndex : Int) -> location{
        var _location : location?
        self._datas.forEach { element in
            if element.key == componentIndex {
                _location = element
            }
        }
        guard let _location = _location else {
            fatalError()
        }
        return _location
    }
}
protocol modelObject {
    var name : String { get }
    var key : Int { get }
}
struct location: modelObject {
    var name: String
    var key: Int
    var stations: [station] {
        get {
            return self._stations
        }
    }
    private var _stations: [station] = []
    init(setName : String, setKey : Int, stations: [station]) {
        self.name = setName
        self.key = setKey
        self._stations = stations
    }
}

struct station: modelObject {
    var name: String
    var key: Int
    init(setName : String, setKey : Int) {
        self.name = setName
        self.key = setKey
    }
}
