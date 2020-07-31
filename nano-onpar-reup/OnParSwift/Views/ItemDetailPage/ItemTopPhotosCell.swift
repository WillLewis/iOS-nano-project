//
//  ItemTopPhotosCell.swift
//  OnParSwift
//
//  Created by William Lewis on 5/15/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class ItemTopSectionCell: UICollectionViewCell {
    
    let horizontalController = ItemTopPhotosController()
    
    var item: Item? {
        didSet {
            brandLabel.text = item?.brand
            nameLabel.text = item?.name
            modelLabel.text = item?.model
        }
    }
    
    let brandLabel: UILabel = {
        let brandLabel = UILabel()
        let brandAttributedText = NSMutableAttributedString( string: "ROLEX")
        brandLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        brandLabel.attributedText = brandAttributedText
        brandLabel.numberOfLines = 1
        return brandLabel
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        let nameAttributedText = NSMutableAttributedString( string: "Daytona")
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        nameLabel.attributedText = nameAttributedText
        nameLabel.numberOfLines = 1
        return nameLabel
    }()
    
    let modelLabel: UILabel = {
        let modelLabel = UILabel()
        let modelAttributedText = NSMutableAttributedString( string: "116340")
        modelLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        modelLabel.attributedText = modelAttributedText
        modelLabel.numberOfLines = 1
        return modelLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor2(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))

        let stackView = VerticalStackView(arrangedSubviews: [
        brandLabel, nameLabel, modelLabel], spacing: 12)
        
        addSubview(stackView)
        stackView.anchor2(top: horizontalController.view.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 0))
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
}
