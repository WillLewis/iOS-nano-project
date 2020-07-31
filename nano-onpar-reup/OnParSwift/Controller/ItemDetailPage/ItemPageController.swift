//
//  ItemDetail.swift
//  OnParSwift
//
//  Created by William Lewis on 5/15/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import JGProgressHUD

class ItemPageController: InitCollectionViewController, UICollectionViewDelegateFlowLayout{
   
    //MARK: --save to later to make code safer and more testable
    //fileprivate let itemId: String
    ///dependency injection constructor
//    init(itemId: String) {
//        self.itemId = itemId
//        super.init()
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var item: Item?
    var listener: ListenerRegistration!
    var db: Firestore!
    
    let topPhotosCellId = "topPhotosCellId"
    let aboutTextCellId = "aboutTextCellId"
    let highlightsCellId = "highlightsCellId"
    let detailsCellId = "detailsCellId"
    let bottomControls = BottomControlsStackView()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        collectionView.register(ItemTopSectionCell.self, forCellWithReuseIdentifier: topPhotosCellId)
        collectionView.register(AboutTextCell.self, forCellWithReuseIdentifier: aboutTextCellId)
        collectionView.register(HighlightsCell.self, forCellWithReuseIdentifier: highlightsCellId)
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: detailsCellId)
        //fetchItemSetListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        
        setupView()
    }
    
    fileprivate let hud = JGProgressHUD(style: .dark)
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    //MARK: TODO --Save this for speed testing query vs pulling from full array
//    func fetchItemSetListener(){
//        hud.show(in: view)
//        
//        let query = db.collection("items")
//        query.document(itemId).getDocument { (snapshot, err) in
//            self.hud.dismiss()
//            if let err = err {
//                print("Error:", err)
//                return
//            }
//             
//            guard let dictionary = snapshot?.data() else {return}
//            let item = Item(firestoreDoc: dictionary)
//            self.item = item
//            
//            print(" Selected document id is: \(self.itemId)")
//            print(" Selected item is: \(String(describing: self.item?.name))")
//            
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }
    
    fileprivate func setupView() {
        collectionView.backgroundColor = .white
        bottomControls.addShadowBackground(color: .white)

        bottomControls.statusTextLabel.text = "AVAILABLE \(item?.inspectionTimeDate ?? "AVAILABLE")"
        view.addSubview(bottomControls)
        let tabHeight = self.tabBarController?.tabBar.frame.origin.y ?? 49
        bottomControls.anchor2(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: tabHeight, right: 0))
        setupCloseButton()
        
    }
    
    func setupCloseButton(){
        view.addSubview(closeButton)
        closeButton.anchor2(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 48, left: 0, bottom: 0, right: 4), size: .init(width: 44, height: 44))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topPhotosCellId, for: indexPath) as! ItemTopSectionCell
            cell.item = item
            cell.horizontalController.item = self.item
            return cell
        
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: aboutTextCellId, for: indexPath) as! AboutTextCell
            cell.item = item
            return cell
            
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: highlightsCellId, for: indexPath) as! HighlightsCell
            cell.highlightsController.item = self.item
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailsCellId, for: indexPath) as! DetailsCell
            cell.detailController.item = self.item
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 200
        
        if indexPath.item == 0 {
            height = 600
        } else if indexPath.item == 1 {
            //programatically set size for cell with about text content which can vary in length
            let adjustingCell = AboutTextCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 300))
            //adjustingCell.item = item
            adjustingCell.layoutIfNeeded()
            
            let estimatedSize = adjustingCell.systemLayoutSizeFitting(.init(width: 300, height: 300))
            height = estimatedSize.height
        } else if indexPath.item == 2 {
            height = 300
        } else {
            height = 550
        }
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
}
