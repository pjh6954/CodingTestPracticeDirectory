//
//  ViewController.swift
//  CardSlideExampleApp
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cardSlider = SliderViewController.with(dataSource: self)
        cardSlider.modalPresentationStyle = .fullScreen
        present(cardSlider, animated: true, completion: nil)
    }
}

extension ViewController : CardSliderDataSource {
    func item(for index: Int) -> CardSliderItem {
        return movies[index]
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
}
