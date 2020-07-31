//  initiallizes collection view
//  InitCollectionViewController.swift
//  OnParSwift
//
//  Created by William Lewis on 5/15/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class InitCollectionViewController: UICollectionViewController {
    
    init() {
            super.init(collectionViewLayout: UICollectionViewFlowLayout())
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
}
