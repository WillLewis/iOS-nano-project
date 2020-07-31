//
//  BottomControlsStackView.swift
//  OnParSwift
//
//  Created by William Lewis on 5/24/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class BottomControlsStackView: UIStackView {
    
    var item: Item! {
        didSet {
            statusTextLabel.text = item?.inspectionTimeDate
        }
    }
    
    let statusTextLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "AVAILABLE 05/14 @ 9:00 AM", attributes: [.foregroundColor: UIColor.black])
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    let dynamicButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        heightAnchor.constraint(equalToConstant: 110).isActive = true
        statusTextLabel.textAlignment = .center
        
        dynamicButton.translatesAutoresizingMaskIntoConstraints = false
        let heightContraints = NSLayoutConstraint(item: dynamicButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([heightContraints])
        
        dynamicButton.setTitle("Notify Me", for: .normal)
        dynamicButton.backgroundColor = .black
        dynamicButton.layer.cornerRadius = 5
        dynamicButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        dynamicButton.setTitleColor(.white, for: .normal)
        
        
        [statusTextLabel, UIView(), dynamicButton].forEach { (v) in
            addArrangedSubview(v)
        }
        //alignment = .center
        distribution = .fillProportionally
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}


