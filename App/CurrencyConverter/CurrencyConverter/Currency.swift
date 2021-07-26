//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Dannian Park on 2021/07/26.
//

import Foundation

struct Currency {
    let code: String
    let flag: String
    let name: String
    let symbol: String
    let countryName: String
    
    static let null: Currency = Currency(code: "", flag: "", name: "", symbol: "", countryName: "")
}

extension Currency: Hashable {
    var hashValue: Int { return code.hashValue }
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
        //code.hashValue
        /*
        switch self {
        case .small:
            hasher.combine(0)
        case .medium:
            hasher.combine(1)
        case .large:
            hasher.combine(2)
        }
        */
    }
}

func ==(lhs: Currency, rhs: Currency) -> Bool {
    return lhs.code == rhs.code
}

extension Currency: CustomStringConvertible {
    var description: String { return "(\(code) \(name))" }
}
