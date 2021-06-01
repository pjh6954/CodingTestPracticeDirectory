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
        print("View did appear")
        let cardSlider = SliderViewController.with(dataSource: self)
        cardSlider.modalPresentationStyle = .fullScreen
        present(cardSlider, animated: true, completion: nil)
    }
}

extension ViewController : CardSliderDataSource {
    // TODO: Infinite Mode
    func activateInfinite(displayCount: Int) {
        guard let first = movies.first, movies.count >= 1 else {
            return
        }
        let moviesTemp = movies
        if movies.count < displayCount {
            movies.append(first)
            if let last = movies.last {
                movies.insert(last, at: 0)
            } else {
                movies.insert(first, at: 0)
            }
        }else{
            let firstMovies = Array(moviesTemp[0..<displayCount - 1])
            let lastMovies = Array(moviesTemp[movies.count - displayCount + 1..<movies.count])
            for i in 0 ..< displayCount - 1 {
                movies.insert(lastMovies[i], at: i)
            }
            movies += firstMovies
        }
        /*
        if movies.count == 1 {
            movies.append(first)
        }else{
            let last = movies.last
            movies.append(first)
            movies.insert(last!, at: 0)
        }
        */
        
    }
    func item(for index: Int) -> CardSliderItem {
        return movies[index]
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
}
