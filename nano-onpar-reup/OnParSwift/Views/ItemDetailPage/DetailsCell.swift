//
//  DetailsCell.swift
//  OnParSwift
//
//  Created by William Lewis on 5/18/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class DetailsCell: UICollectionViewCell {
    
    
    
    let detailSectionTitle = UILabel(text: "Details", font: .boldSystemFont(ofSize: 20), numberOfLines: 1)
    
    let detailController = ItemDetailsController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(detailSectionTitle)
        addSubview(detailController.view)
        
        detailSectionTitle.anchor2(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 40, left: 16, bottom: 0, right: 16))
        
        detailController.view.anchor2(top: detailSectionTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
