//
//  SliderViewController.swift
//  CardSlideExampleApp
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

class SliderViewController : UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    
    public weak var dataSource: CardSliderDataSource!
    
    let cellID = "SliderCell"
    
    public static func with(dataSource: CardSliderDataSource) -> SliderViewController {
        if let controller = UIStoryboard(name: "SliderViewController", bundle: nil).instantiateInitialViewController() as? SliderViewController {
            controller.dataSource = dataSource
            return controller
        }
        fatalError("Failed to initialize SliderViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delaysContentTouches = false
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if let layout = self.collectionView.collectionViewLayout as? SliderLayout {
            if layout.type == .rightVisible {
                self.collectionView.transform = .init(scaleX: -1, y: 1)
            }
            
            // TODO: Infinite mode
            //if layout.scrollMode == .activate {
            //    dataSource.activateInfinite(displayCount: layout.visibleItemsCount)
            //}
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.layoutIfNeeded()
        
    }
    
    private func prepareFirstCard() {
        //guard let layout = self.collectionView.collectionViewLayout as? CardLayout else {return}
    }
}

extension SliderViewController : UIScrollViewDelegate {
    
}

extension SliderViewController : SliderLayoutDelegate {
    func transition(between currentIndex: Int, and nextIndex: Int, progress: CGFloat) {
        
    }
}
