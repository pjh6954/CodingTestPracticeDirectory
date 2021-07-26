//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Dannian Park on 2021/07/26.
//

import UIKit
import SwiftUI

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var reloadBtn: UIBarButtonItem!
    @IBOutlet weak var upperCurrencyView: CurrencyView!
    @IBOutlet weak var upperCurrencyViewContainer: UIView!
    @IBOutlet weak var lowerCurrencyView: CurrencyView!
    @IBOutlet weak var lowerCurrencyViewContainer: UIView!
    @IBOutlet weak var swapVerticalBtn: UIButton!
    @IBOutlet weak var swapHorizontalBtn: UIButton!
    
    private var currencyViewControllerUpper: UIHostingController<SwiftUICurrencyView>?
    private var currencyViewControllerLower: UIHostingController<SwiftUICurrencyView>?
    
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate var numberUnlocked = true
    //fileprivate var reloadBag = Variable<DisposeBag?>(nil)
    fileprivate var reloadBag = BehaviorRelay<DisposeBag?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if self.currencyViewControllerUpper == nil {
            //self.currencyViewControllerUpper = .init()
            let vc = UIHostingController(rootView: SwiftUICurrencyView())
            
            //let parent = UIViewController()
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.view.frame = self.upperCurrencyViewContainer.bounds
            // First, add the view of the child to the view of the parent
            self.upperCurrencyViewContainer.addSubview(vc.view)
            // Then, add the child to the parent
            self.addChild(vc)
            self.currencyViewControllerUpper = vc
        }
        
        if self.currencyViewControllerLower == nil {
            //self.currencyViewControllerUpper = .init()
            let vc = UIHostingController(rootView: SwiftUICurrencyView())
            
            //let parent = UIViewController()
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.view.frame = self.lowerCurrencyViewContainer.bounds
            // First, add the view of the child to the view of the parent
            self.lowerCurrencyViewContainer.addSubview(vc.view)
            // Then, add the child to the parent
            self.addChild(vc)
            self.currencyViewControllerLower = vc
        }
        */
        setupSubscriptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadViewIfNeeded()
        self.upperCurrencyViewContainer.setNeedsDisplay()
        self.lowerCurrencyViewContainer.setNeedsDisplay()
    }
}

extension ViewController {
    func reload() {
        let reloadDisposeBag = DisposeBag()
        
        //reloadBag.value = reloadDisposeBag
        reloadBag.accept(reloadDisposeBag)
        
        /*
        let reload = API.default.request(.latest)
            .observeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .background))
            .flatMap { CurrencyFactory.instance.rx.parse(json: $0) }
            .observeOn(MainScheduler.instance).publish()
        
        reload
            .subscribe(
                onError: { [weak self] error in
                    self?.reloadBag.value = nil
                },
                onCompleted: { [weak self] error in
                    self?.reloadBag.value = nil
                }
            )
            .addDisposableTo(reloadDisposeBag)
        
        reload.connect().addDisposableTo(reloadDisposeBag)
        */
        let reload = API.default.request(.latest)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap{ CurrencyFactory.instance.rx.parse(json: $0) }
            .observe(on: MainScheduler.instance).publish()
        
        reload.subscribe(onError: { [weak self] error in
            self?.reloadBag.accept(nil)
        }, onCompleted: { [weak self] in
            self?.reloadBag.accept(nil)
        }).disposed(by: reloadDisposeBag)
        
        reload.connect().disposed(by: reloadDisposeBag)
    }
}

extension ViewController {
    fileprivate func setupSubscriptions() {
        // reload
        do {
            CurrencyNotitification.checkReload.rx.post
                .map { _ in return }
                .filter { _ in
                    guard let updated = CurrencyFactory.instance.updatedTime else {
                        return true
                    }
                    return Date().timeIntervalSince1970 - updated > API.default.updateInterval
                }
                .debounce(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
                .bind(onNext: reload)
                .disposed(by: disposeBag)
            
            reloadBtn.rx.tap
                .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
                .bind(onNext: reload)
                .disposed(by: disposeBag)
            
            Observable.from([rx.isLoading.map { !$0 }, reloadBtn.rx.tap.map { false } ])
                .merge()
                //.bindTo(reloadBtn.rx.enabled)
                .bind(to: reloadBtn.rx.isEnabled)
                //.addDisposableTo(disposeBag)
                .disposed(by: disposeBag)
            
            reloadBag.asObservable()
                .map { $0 != nil }
                //.bindTo(UIApplication.shared.rx.networkActivityIndicatorVisible)
                .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
                //.addDisposableTo(disposeBag)
                .disposed(by: disposeBag)
        }
        
        // rate date
        do {
            Observable.combineLatest(CurrencyFactory.instance.rx.rateDateString, rx.isLoading) { (string, isLoading) in
                return isLoading ? "Refreshing..." : "Rates at \(string)"
            }
            .observe(on: MainScheduler.instance)
            .bind(to: rx.title)
            .disposed(by: disposeBag)
        }
        
        // API loaded
        do {
            let initial = CurrencyFactory.instance.rx.currencies.take(1).observe(on: MainScheduler.instance).publish()
            
            //initial
            //    .map { [weak self] _ in self?.defaultUpperCurrency ?? Currency.null }
            //    .bindTo(upperCurrencyView.rx.currency)
            //    .addDisposableTo(disposeBag)
            initial.map { [weak self] _ in
                self?.defaultUpperCurrency ?? Currency.null
            }
            .bind(to: upperCurrencyView.rx.currency)
            .disposed(by: disposeBag)
            
            //initial
            //    .map { [weak self] _ in self?.defaultLowerCurrency ?? Currency.null }
            //    .bindTo(lowerCurrencyView.rx.currency)
            //    .addDisposableTo(disposeBag)
            initial.map { [weak self] _ in self?.defaultLowerCurrency ?? Currency.null }
                .bind(to: lowerCurrencyView.rx.currency)
                .disposed(by: disposeBag)
            
            //initial.map { _ in return }.bindNext(lockNumber).addDisposableTo(disposeBag)
            initial.map { _ in return }
                .bind(onNext: lockNumber)
                .disposed(by: disposeBag)

            //initial
            //    .map { _ in Settings.instance.lowerNumber ?? 0 }
            //    .bindTo(lowerCurrencyView.rx.number)
            //    .addDisposableTo(disposeBag)
            initial.map { _ in Settings.instance.lowerNumber ?? 0 }
                .bind(to: lowerCurrencyView.rx.number)
                .disposed(by: disposeBag)

            //initial.connect().addDisposableTo(disposeBag)
            initial.connect().disposed(by: disposeBag)
        }
        
        // API loaded
        do {
            let update = CurrencyFactory.instance.rx.currencies.skip(1).observe(on: MainScheduler.instance).publish()

            //update
            //    .subscribe(onNext: { [weak self] _ in
            //        guard let sself = self else { return }
            //        let currency = sself.upperCurrencyView.currency
            //        sself.upperCurrencyView.currency =
            //            CurrencyFactory.instance.contains(currencyCode: currency.code) ?
            //                currency : sself.defaultUpperCurrency
            //    })
            //    .addDisposableTo(disposeBag)
            update.subscribe(onNext: { [weak self] _ in
                guard let sself = self else { return }
                let currency = sself.upperCurrencyView.currency
                sself.upperCurrencyView.currency = CurrencyFactory.instance.contains(currencyCode: currency.code) ? currency : sself.defaultUpperCurrency
            }).disposed(by: disposeBag)
            
            //update
            //    .subscribe(onNext: { [weak self] _ in
            //        guard let sself = self else { return }
            //        if CurrencyFactory.instance.contains(currencyCode: sself.lowerCurrencyView.currency.code) { return }
            //        sself.lowerCurrencyView.currency = sself.defaultLowerCurrency
            //    })
            //    .addDisposableTo(disposeBag)
            update.subscribe(onNext: { [weak self] _ in
                guard let sself = self else { return }
                if CurrencyFactory.instance.contains(currencyCode: sself.lowerCurrencyView.currency.code) { return }
                sself.lowerCurrencyView.currency = sself.defaultLowerCurrency
            })
            .disposed(by: disposeBag)
            
            //update.connect().addDisposableTo(disposeBag)
            update.connect().disposed(by: disposeBag)
        }
        /*
        // convert action
        do {
            //let toLower = Observable.combineLatest(
            //    upperCurrencyView.rx.number,
            //    lowerCurrencyView.rx.currency
            //) { $0 }
            //    .filter { [weak self] _ in self?.checkLock() ?? false }
            //    .map { [weak upperCurrencyView] in
            //        ($0, upperCurrencyView?.currency ?? Currency.null, $1)
            //    }
            //    .map(CurrencyFactory.instance.convert)
            //    .publish()
            
            //let toLower = Observable.combineLatest(
            //    upperCurrencyView.rx.number
            //    //, lowerCurrencyView.rx.currency
            //) { $0 }
            //.filter{ [weak self] _ in self?.checkLock() ?? false }
            let toLower = Observable.combineLatest(upperCurrencyView.rx.currency, lowerCurrencyView.rx.currency)
                .filter{ [weak self] _ in self?.checkLock() ?? false }
                .map { [weak self] in
                    let test = $0
                    
                }
            toLower
            
            toLower.map { _ in return }.bindNext(lockNumber).addDisposableTo(disposeBag)
            toLower.bindTo(lowerCurrencyView.rx.number).addDisposableTo(disposeBag)
            
            toLower.connect().addDisposableTo(disposeBag)
            
            
            let toUpper = Observable.combineLatest(
                lowerCurrencyView.rx.number,
                upperCurrencyView.rx.currency
            ) { $0 }
                .filter { [weak self] _ in self?.checkLock() ?? false}
                .map { [weak lowerCurrencyView] in
                    ($0, lowerCurrencyView?.currency ?? Currency.null, $1)
                }
                .map(CurrencyFactory.instance.convert)
                .publish()
            
            toUpper.map { _ in return }.bindNext(lockNumber).addDisposableTo(disposeBag)
            toUpper.bindTo(upperCurrencyView.rx.number).addDisposableTo(disposeBag)
            
            toUpper.connect().addDisposableTo(disposeBag)
        }
        */
        
        // swap
        do {
            Observable.from([swapHorizontalBtn.rx.tap, swapVerticalBtn.rx.tap])
                .merge().bind(onNext: swap).disposed(by: disposeBag)
        }
        
        // status
        do {
            //upperCurrencyView.rx.currency.bindTo(Settings.instance.rx.upperCurrency).addDisposableTo(disposeBag)
            upperCurrencyView.rx.currency.bind(to: Settings.instance.rx.upperCurrency).disposed(by: disposeBag)
            //lowerCurrencyView.rx.currency.bindTo(Settings.instance.rx.lowerCurrency).addDisposableTo(disposeBag)
            lowerCurrencyView.rx.currency.bind(to: Settings.instance.rx.lowerCurrency).disposed(by: disposeBag)
            //lowerCurrencyView.rx.number.bindTo(Settings.instance.rx.lowerNumber).addDisposableTo(disposeBag)
            lowerCurrencyView.rx.number.bind(to: Settings.instance.rx.lowerNumber).disposed(by: disposeBag)
        }
    }
}

extension ViewController {
    fileprivate var defaultUpperCurrency: Currency {
        return Settings.instance.upperCurrency ??
            CurrencyFactory.instance.currency(ofLocale: Locale.current) ??
            CurrencyFactory.instance.currency(ofCode: "USD") ??
            CurrencyFactory.instance.firstCurrency ??
            Currency.null
    }

    fileprivate var defaultLowerCurrency: Currency {
        return Settings.instance.lowerCurrency ??
            CurrencyFactory.instance.currency(ofCode: "USD") ??
            CurrencyFactory.instance.firstCurrency ??
            Currency.null
    }

    fileprivate func lockNumber() {
        numberUnlocked = false
    }
    
    fileprivate func checkLock() -> Bool {
        if numberUnlocked { return true }
        numberUnlocked = true
        return false
    }
    
    fileprivate func swap() {
        let upperCurrency = upperCurrencyView.currency
        let upperNumber = upperCurrencyView.number
        
        lockNumber()
        upperCurrencyView.currency = lowerCurrencyView.currency
        lockNumber()
        upperCurrencyView.number = lowerCurrencyView.number
        lockNumber()
        lowerCurrencyView.currency = upperCurrency
        lockNumber()
        lowerCurrencyView.number = upperNumber
    }
    
}

extension Reactive where Base : ViewController {
    
    var isLoading: Observable<Bool> {
        return base.reloadBag.asObservable().map { $0 != nil }
    }
    
}
