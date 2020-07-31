//
//  ItemDetailsController.swift
//  OnParSwift
//
//  Created by William Lewis on 5/19/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class ItemDetailsController: InitCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var item: Item! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    class DetailListCell: UICollectionViewCell {
        
        var detailType: UILabel = {
            let detailType = UILabel(text: "Type", font: .systemFont(ofSize: 12))
            detailType.textColor = .lightGray
            return detailType
        }()

        var detailValue: UILabel = {
            let detailValue = UILabel(text: "Details", font: .boldSystemFont(ofSize: 16))
            return detailValue
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            let stackView = UIStackView(arrangedSubviews: [detailType, detailValue])
            addSubview(stackView)
            stackView.fillSuperview()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.register(DetailListCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        addSeparatorLinesToCollectionView()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowCount = DetailRow.allCases.count
        print("the detail row count is \(rowCount)")
        return rowCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailListCell
        cell.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 0.5)
        
        guard let row = DetailRow(rawValue: indexPath.item) else {return UICollectionViewCell()}

        switch row {
        case .hasBox:
            cell.detailType.text = DetailRow(rawValue: indexPath.row)?.description
            cell.detailValue.text = item.box
        case .hasPapers:
            cell.detailType.text = DetailRow(rawValue: indexPath.row)?.description
            cell.detailValue.text = item.papers
        case .serial:
            cell.detailType.text = DetailRow(rawValue: indexPath.row)?.description
            cell.detailValue.text = item.serialStart
        case .bracelet:
            cell.detailType.text = DetailRow(rawValue: indexPath.row)?.description
            cell.detailValue.text = item.braceletCode
        case .endLink:
            cell.detailType.text = DetailRow(rawValue: indexPath.row)?.description
            cell.detailValue.text = item.endLinkCode
        case .numOflinks:
            cell.detailType.text = DetailRow(rawValue: indexPath.row)?.description
            cell.detailValue.text = item.linkCount
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let properWidth = view.frame.width - 32
        return .init(width: properWidth, height: 50)
    }
    
    func addSeparatorLinesToCollectionView () {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let itemSpacing: CGFloat = 1
        let itemsInOneLine: CGFloat = 1
        let width = UIScreen.main.bounds.size.width - itemSpacing * CGFloat(itemsInOneLine - 1)
        flowLayout.itemSize = CGSize(width: floor(width/itemsInOneLine), height: width/itemsInOneLine)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = 2
        
        collectionView?.setCollectionViewLayout(flowLayout, animated: false)
        
    }

    
    
}
