//
//  CardViews.swift
//  OnParSwift
//
//  Created by William Lewis on 4/18/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class ItemCardButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size.height = 30
        layer.cornerRadius = 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        
    }
}

class ItemCardName: UILabel {
    override func awakeFromNib() {
        self.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        self.textColor = UIColor.black
    }
}

class ItemCardModel: UILabel {
    override func awakeFromNib() {
        self.font = UIFont(name: "Helvetica Neue", size: 14)
        self.textColor = UIColor.systemGray
    }
}

class ItemCardAvailability: UILabel {
    override func awakeFromNib() {
        self.font = UIFont(name: "Helvetica Neue", size: 14)
        self.textColor = UIColor.systemGray
    }
}

class ItemCardImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class ItemCardView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

class SectionHeader: UICollectionReusableView {
    
     var sectionLabel: UILabel? = {
        let sectionLabel: UILabel = UILabel()
        sectionLabel.textColor = .black
        sectionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        sectionLabel.sizeToFit()
     return sectionLabel
     }()

    override init(frame: CGRect) {
         super.init(frame: frame)

        addSubview(sectionLabel ?? UILabel())

        sectionLabel?.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel?.anchor2(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) failed")
    }
}
