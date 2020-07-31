//  UpcomingViewController.swift
//
//  Created by William Lewis on 4/2/20.
//  Copyright © 2020 Google Inc. All rights reserved.

import UIKit
import Firebase
import FirebaseUI

class UpcomingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ItemCellDelegate {
    
    let itemCellId = "ItemCell"
    let headerId = "header"
    var category: Category!
    var items = [Item]()
    var datasourceItems = [[Item]]()
    private var documents: [DocumentSnapshot] = []
    var showNotificationItems = false
    var db: Firestore!
    var listener: ListenerRegistration!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weekdaysMap = [
        "TODAY",
        "TOMORROW",
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY",
        "UPCOMING"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<weekdaysMap.count {
            datasourceItems.append([])
        }
        
        db = Firestore.firestore()
        setupCollectionView()
        setupBars()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setItemsListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        listener.remove()
        items.removeAll()
        datasourceItems.removeAll()
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: itemCellId, bundle: nil), forCellWithReuseIdentifier: itemCellId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .mainBackgroundGrey()
        
    }
    
    func setupBars(){
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.backgroundColor = .white
        tabBarController?.tabBar.isTranslucent = false
    }
    
    func itemNotificationsToggled(item: Item) {
        if FBAPI.isGuest {
            self.simpleAlert(title: "Hold Up!", msg: "This is a user only feature. Please sign up to do this.")
            return
        }
        FBAPI.notifyButtonPressed(item: item)
        
        for section in 0..<datasourceItems.count {
            for datasourceItem in 0..<datasourceItems[section].count {
                if datasourceItems[section][datasourceItem] == item {
                    collectionView.reloadItems(at: [IndexPath(row: datasourceItem, section: section)])
                }
            }
        }
    }
    
    func setItemsListener() {
        
        listener = Firestore.firestore().items.addSnapshotListener{ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
            self.resetItems()
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let item = Item.init(firestoreDoc: data)

                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, item: item)
                case .modified:
                    self.onDocumentModified(change: change, item: item)
                case .removed:
                    ///--not needed now because we arent removing docs
                    print("not needed")
                    ///self.onDocumentRemoved(change: change)
                }
            })
        }
    }
    
    fileprivate func resetItems(){
        collectionView.reloadData()
    }
    
    func onDocumentAdded(change: DocumentChange, item: Item) {
        let weekdayIndex = weekdaysMap.firstIndex(of: item.inspectionDay)
        if let weekdayIndex = weekdayIndex {
            collectionView!.numberOfItems(inSection: 0)
            datasourceItems[weekdayIndex].append(item) //<-- Code not used. Lets UICollectionView synchronize number of items, there isnt a race conditions
            collectionView.insertItems(at: [IndexPath(item: datasourceItems[weekdayIndex].count-1 , section: weekdayIndex)])
        }
    }
    
    func onDocumentModified(change: DocumentChange, item: Item) {
        /// item changed but position is the same
        if change.oldIndex == change.newIndex {
            let weekdayIndex = weekdaysMap.firstIndex(of: item.inspectionDay)
            if let weekdayIndex = weekdayIndex {
                if let i = self.datasourceItems[weekdayIndex].firstIndex(of: item) {
                    self.datasourceItems[weekdayIndex][i] = item
                    collectionView.reloadItems(at: [IndexPath(item: i, section: weekdayIndex)])
                }
            }
        } else {
            /// item and  position changed
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            //MARK: correct: let weekdayIndex = weekdaysMap[item.inspectionDay].key
            let weekdayIndex = weekdaysMap.firstIndex(of: item.inspectionDay)

            ///--not needed now because we arent removing docs
            datasourceItems.remove(at: oldIndex)
            datasourceItems.insert([item], at: newIndex)
            if let weekdayIndex = weekdayIndex {
            collectionView.moveItem(at: IndexPath(item: oldIndex, section: weekdayIndex), to: IndexPath(item: newIndex, section: weekdayIndex))
            }
        }
    }
    
///  --not needed now because we arent removing docs
///    func onDocumentRemoved(change: DocumentChange) {
///        let oldIndex = Int(change.oldIndex)
///        items.remove(at: oldIndex)
///        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
///    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return datasourceItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasourceItems[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! ItemCell
            cell.configureCell(item: datasourceItems[indexPath.section][indexPath.item], delegate: self)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SectionHeader
       
        //MARK: TODO --Remove sections with no items
        let date = Array(weekdaysMap)[indexPath.section]
            sectionHeader.sectionLabel?.text = date
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItem = datasourceItems[indexPath.section][indexPath.item]
        let vc = ItemPageController()
        vc.item = selectedItem
        print("UpcomingVC Selected item is \(selectedItem.name)")
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.width
        let height: CGFloat = 360

        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
}
    
    
    
