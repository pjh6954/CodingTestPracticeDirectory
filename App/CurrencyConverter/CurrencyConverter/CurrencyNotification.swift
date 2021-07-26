//
//  CurrencyNotification.swift
//  CurrencyConverter
//
//  Created by Dannian Park on 2021/07/26.
//

import Foundation

import RxSwift
import RxCocoa

enum CurrencyNotitification: String {
    case checkReload
    
    var name : Notification.Name {
        return Notification.Name(self.rawValue)
    }
}

extension CurrencyNotitification {
    func post(object: AnyObject? = nil, userInfo: [NSObject: AnyObject]? = nil) {
        NotificationCenter.default.post(name: self.name, object: object, userInfo: userInfo)
    }
    
    struct Reactive {
        fileprivate let base : CurrencyNotitification
        
        init(_ base : CurrencyNotitification) {
            self.base = base
        }
    }
    
    var rx: Reactive { return Reactive(self) }
}

extension CurrencyNotitification.Reactive {
    var post: Observable<Notification> {
        return NotificationCenter.default.rx.notification(base.name)
    }
}
