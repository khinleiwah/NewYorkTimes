//
//  HomeImageCollectionViewCell.swift
//  NewYorkTimes
//
//  Created by Win on 4/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import UIKit

class HomeImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var snippet: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
//    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.4
      
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return layoutAttributes
    }
}
