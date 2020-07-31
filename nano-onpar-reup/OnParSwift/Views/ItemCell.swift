//  ItemCell.swift
//  OnParSwift
//
//  Created by William Lewis on 4/18/20.
//  Copyright © 2020 Google Inc. All rights reserved.

import UIKit
import Firebase
import Kingfisher

protocol ItemCellDelegate: class {
    func itemNotificationsToggled(item: Item)
}

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var itemImage: ItemCardImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemModel: ItemCardModel!
    @IBOutlet weak var itemInspectionDateTime: UILabel!
    @IBOutlet weak var notifyMeButton: ItemCardButton!
    
    weak var delegate: ItemCellDelegate?
    private var item: Item!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(item: Item, delegate: ItemCellDelegate) {
        self.item = item
        self.delegate = delegate
        
        itemTitle.text = item.name
        itemModel.text = item.model
        itemInspectionDateTime.text = item.inspectionTimeDate
        
        if let url = URL(string: item.feedImageUrl) {
            let placeholder = #imageLiteral(resourceName: "placeholderView")
            itemImage.kf.indicatorType = .activity
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            itemImage.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
        
        if FBAPI.notifyingItems.contains(item) {
            notifyMeButton.backgroundColor = .black
            notifyMeButton.setImage(#imageLiteral(resourceName: "NotifyOnButtonContents"), for: .normal)
        } else {
            notifyMeButton.setImage(#imageLiteral(resourceName: "NotifyMeButtonContents"), for: .normal)
            notifyMeButton.backgroundColor = .white
        }
    }
    
    @IBAction func notifyMeButtonHandled(_ sender: Any) {
            delegate?.itemNotificationsToggled(item: self.item)
        
    }
    
}
