//
//  HighlightsPhotosController.swift
//  OnParSwift
//
//  Created by William Lewis on 5/16/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class HighlightsPhotosController: HorizontalSnapController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let highlightUrls = [String]()
    
    var item: Item? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    class HighlightsPhotoCell: UICollectionViewCell {
        let imageView = UIImageView(cornerRadius: 0)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            imageView.backgroundColor = .white
            addSubview(imageView)
            imageView.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(HighlightsPhotoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HighlightsPhotoCell
        
        let highlightUrls = [self.item?.highlightImageUrl1, self.item?.highlightImageUrl2, self.item?.highlightImageUrl3, self.item?.highlightImageUrl4, self.item?.highlightImageUrl5]
        
        let picUrl = highlightUrls[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: picUrl ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 300, height: view.frame.height)
    }
}
