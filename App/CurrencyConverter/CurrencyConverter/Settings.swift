//
//  Settings.swift
//  CurrencyConverter
//
//  Created by Dannian Park on 2021/07/26.
//

import Foundation

import RxCocoa
import RxSwift

fileprivate enum Key: String {
    case rateUpdatedTime, rateDate, rates
    case upperCurrency, lowerCurrency, lowerNumber
}

class Settings : ReactiveCompatible {
    
    static let instance = Settings()
    
    private var storage: UserDefaults = UserDefaults.standard
    
    var rateUpdatedTime: TimeInterval? {
        get { return storage.double(forKey: Key.rateUpdatedTime.rawValue) }
        set { storage.set(newValue, forKey: Key.rateUpdatedTime.rawValue) }
    }

    var rateDate: Date? {
        get { return storage.object(forKey: Key.rateDate.rawValue)  as? Date }
        set { storage.set(newValue, forKey: Key.rateDate.rawValue) }
    }

    var rates: [String : CurrencyRate]? {
        get {
            guard let dic = storage.dictionary(forKey: Key.rates.rawValue) as? [String : Double] else { return nil }
            var rates: [String : CurrencyRate] = [:]
            for (code, rate) in dic {
                rates[code] = CurrencyRate(currencyCode: code, rate: rate)
            }
            return rates
        }
        
        set {
            guard let rates = newValue else {
                storage.set(nil, forKey: Key.rates.rawValue)
                return
            }
            var dic: [String : Double] = [:]
            for (key, value) in rates { dic[key] = value.rate }
            storage.set(dic, forKey: Key.rates.rawValue)
        }
    }
    
    var upperCurrency: Currency? {
        get { return CurrencyFactory.instance.currency(ofCode: storage.string(forKey: Key.upperCurrency.rawValue)) }
        set { storage.set(newValue?.code, forKey: Key.upperCurrency.rawValue) }

    }
    
    var lowerCurrency: Currency? {
        get { return CurrencyFactory.instance.currency(ofCode: storage.string(forKey: Key.lowerCurrency.rawValue)) }
        set { storage.set(newValue?.code, forKey: Key.lowerCurrency.rawValue) }
        
    }
    
    var lowerNumber: Double? {
        get { return storage.double(forKey: Key.lowerNumber.rawValue) }
        set { storage.set(newValue, forKey: Key.lowerNumber.rawValue) }
        
    }

    func synchronize() {
        storage.synchronize()
    }
    
}

extension Reactive where Base : Settings {
    // Need Check :: http://rx-marin.com/post/rxswift-custom-bindings/
    var upperCurrency: AnyObserver<Currency> {
        //return UIBindingObserver(UIElement: base) { setttings, currency in
        //      setttings.upperCurrency = currency
        //    }.asObserver()
        Binder(base) { settings, currency in
            settings.upperCurrency = currency
        }.asObserver()
    }

    var lowerCurrency: AnyObserver<Currency> {
        //return UIBindingObserver(UIElement: base) { setttings, currency in
        //    setttings.lowerCurrency = currency
        //    }.asObserver()
        Binder(base) { settings, currency in
            settings.lowerCurrency = currency
        }.asObserver()
    }
    
    var lowerNumber: AnyObserver<Double> {
        //return UIBindingObserver(UIElement: base) { setttings, number in
        //    setttings.lowerNumber = number
        //    }.asObserver()
        return Binder(base) { settings, number in
            settings.lowerNumber = number
        }.asObserver()
    }
    
}

