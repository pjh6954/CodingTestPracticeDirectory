//
//  API.swift
//  CurrencyConverter
//
//  Created by Dannian Park on 2021/07/26.
//

import Foundation

import RxCocoa
import RxSwift
import Alamofire
import RxAlamofire
import SwiftyJSON

enum API {
    
    static let `default`: APIServer = DefaultAPIServer()
    
    case latest
    
}

protocol APIServer {
    //var sessionManager: SessionManager { get }
    var sessionManager : Session { get }
    
    var updateInterval: TimeInterval { get }
    
    func method(_ api: API) -> HTTPMethod
    
    func url(_ api: API) -> String
}

extension APIServer {
    
    func request(_ api: API, parameters: [String : AnyObject]? = nil) -> Observable<SwiftyJSON.JSON> {
        return sessionManager.rx.responseJSON(method(api), url(api), parameters: parameters)
            .map {
                print("Check $0 : \($0), $1 \($1)")
                return SwiftyJSON.JSON( $1 as? [String: AnyObject])
            }
            .do(onNext: {
                    print("Check \($0)")
                    print("Check url : \(url(api))")
                    print("\(NSDate()) Reloaded: \($0["rates"].count) items")
            })
    }

}

struct DefaultAPIServer : APIServer {
    
    private let baseServerURL = "https://data.fixer.io/api"//"https://api.fixer.io"
    
    var updateInterval: TimeInterval { return 24 * 60 * 60 }
    /*
    let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return SessionManager(configuration: configuration)
    }()
    */
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        //return SessionManager(configuration: configuration)
        return Session(configuration: configuration)
    }()
    
    func method(_ api: API) -> HTTPMethod {
        switch api {
        case .latest: return .get
        }
    }
    
    func url(_ api: API) -> String {
        switch api {
        case .latest: return "\(baseServerURL)/latest"
            //https://data.fixer.io/api/latest
        }
    }
    
}
