//
//  SliderCell.swift
//  CardSlideExampleApp
//
//  Created by Dannian Park on 2021/05/26.
//

import UIKit

class SliderCell: UICollectionViewCell, ParallaxCardCell {
    var cornerRadius: CGFloat = 10 { didSet { update() }}
    var shadowOpacity: CGFloat = 0.3 { didSet { update() }}
    var shadowColor: UIColor = .black { didSet { update() }}
    var shadowRadius: CGFloat = 20 { didSet { update() }}
    var shadowOffset: CGSize = CGSize(width: 0, height: 20) { didSet { update() }}
    
    /// Maximum image zoom during scrolling
    var maxZoom: CGFloat {
        return 1.3
    }
    
    private var zoom : CGFloat = 0.0
    private var shadeOpacity : CGFloat = 0.0
    
    var imageView = UIImageView()
    var shadeView = UIView()
    var highlightView = UIView()
    
    private var latestBounds: CGRect?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        shadeView.backgroundColor = .white
        contentView.addSubview(shadeView)
        highlightView.backgroundColor = .black
        highlightView.alpha = 0
        contentView.addSubview(highlightView)
    }
    
    // protocol
    func setShadeOpacity(progress: CGFloat) {
        shadeOpacity = progress
        updateShade()
        updateShadow()
    }
    
    func setZoom(progress: CGFloat) {
        zoom = progress
        updateImagePosition()
    }
    
    override var bounds: CGRect {
        didSet {
            guard latestBounds != bounds else {return}
            latestBounds = bounds
            highlightView.frame = bounds
            update()
        }
    }
    
    private func update() {
        updateImagePosition()
        updateShade()
        updateMask()
        updateShadow()
    }
    
    func updateShade() {
        shadeView.frame = bounds.insetBy(dx: -2, dy: -2)
        shadeView.alpha = 1 - shadeOpacity
    }
    
    func updateImagePosition() {
        zoom = min(zoom, 1)
        imageView.frame = bounds.applying(CGAffineTransform(scaleX: 1 + (1 - zoom), y: 1 + 1 - zoom))
        imageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    func updateMask() {
        let mask = CAShapeLayer()
        let path =  UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        mask.path = path
        contentView.layer.mask = mask
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            UIView.animate(withDuration: newValue ? 0 : 0.3) {
                self.highlightView.alpha = newValue ? 0.2 : 0
            }
        }
    }
    
    func updateShadow() {
        if layer.shadowPath == nil {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            layer.shadowColor = shadowColor.cgColor
            layer.shadowRadius = shadowRadius
            layer.shadowOffset = shadowOffset
            layer.masksToBounds = false
        }
        layer.shadowOpacity = Float(shadowOpacity * shadeOpacity)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setShadeOpacity(progress: 0)
    }
}
