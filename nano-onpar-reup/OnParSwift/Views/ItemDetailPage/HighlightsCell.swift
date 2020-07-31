//
//  HighlightsCell.swift
//  OnParSwift
//
//  Created by William Lewis on 5/16/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class HighlightsCell: UICollectionViewCell {
    
    let highlightLabel = UILabel(text: "Highlights", font: .boldSystemFont(ofSize: 20), numberOfLines: 1)
    let highlightsController = HighlightsPhotosController()
    //var item: Item?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        addSubview(highlightLabel)
        addSubview(highlightsController.view)
        
        highlightLabel.anchor2(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20))
        
        highlightsController.view.anchor2(top: highlightLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
