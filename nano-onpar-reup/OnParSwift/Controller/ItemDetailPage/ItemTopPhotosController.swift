//
//  ItemTopPhotosController.swift
//  OnParSwift
//
//  Created by William Lewis on 5/15/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit
import Foundation

class ItemTopPhotosController: HorizontalSnapController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let topPhotoUrls = [String]()
    var topPage: CGFloat = 0
    let photoPage = Page()
    
    var item: Item? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @objc class Page: NSObject {
        @objc dynamic var pageNumber: CGFloat = 0
    }
    
    lazy var topPhotoPageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = Int(topPage)
        pc.numberOfPages = 5
        pc.currentPageIndicatorTintColor = .white
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }()
    
    class ItemTopPhotosCell: UICollectionViewCell {
        let imageView = UIImageView(cornerRadius: 0)
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            imageView.backgroundColor = .white
            addSubview(imageView)
            imageView.fillSuperview()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.register(ItemTopPhotosCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(topPhotoPageControl)
        topPhotoPageControl.anchor2(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
       if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            photoPage.pageNumber = CGFloat(visibleIndexPath.item)
            topPhotoPageControl.currentPage = Int(photoPage.pageNumber)
       }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK: Todo Change to return count of urls --requires database reconstruction
        return 5
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
     
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemTopPhotosCell
        let topPhotoUrls = [self.item?.topImageUrl1, self.item?.topImageUrl2, self.item?.topImageUrl3, self.item?.topImageUrl4, self.item?.topImageUrl5]
        let picUrl = topPhotoUrls[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: picUrl ?? "" ))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
}
