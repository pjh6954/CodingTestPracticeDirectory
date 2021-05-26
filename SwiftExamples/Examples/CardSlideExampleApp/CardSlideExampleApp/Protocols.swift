//
//  Protocols.swift
//  CardSlideExampleApp
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

/// Model for a card.
public protocol CardSliderItem {
    /// The image for the card.
    var image: UIImage { get }
    
    /// Rating from 0 to 5. If set to nil, rating view will not be displayed for the card.
    var rating: Int? { get }
    
    /// Will be displayed in the title view below the card.
    var title: String { get }
    
    /// Will be displayed under the main title for the card.
    var subtitle: String? { get }
    
    /// Will be displayed as scrollable text in the expanded view.
    var description: String? { get }
}

public protocol CardSliderDataSource: AnyObject {
    /// CardSliderItem for the card at given index, counting from the top.
    func item(for index: Int) -> CardSliderItem
    
    /// Total number of cards.
    func numberOfItems() -> Int
}

protocol ParallaxCardCell {
    func setShadeOpacity(progress: CGFloat)
    func setZoom(progress: CGFloat)
}
