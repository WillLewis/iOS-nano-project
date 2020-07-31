//
//  AboutTextCell.swift
//  OnParSwift
//
//  Created by William Lewis on 5/24/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class AboutTextCell: UICollectionViewCell {
    
    
    var item: Item! {
        didSet {
            aboutTextLabel.text = item?.itemDescription
        }
    }
    
    let aboutTextLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString( string: "This sligtly used watch features original movement, dial, and bracelet and an aftermarket Rolex bezel in place of the factory bezel.")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.attributedText = attributedText
        label.addBetweenlineSpacing(spacingValue: 1.5, lineHeightMultiple: 1.5)
        
        //MARK: -Set to 4 or 5 to limit total lines of text and add more button with alert that shows full text
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(aboutTextLabel)
        aboutTextLabel.fillSuperview(padding: .init(top: 20, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
