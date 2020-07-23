//
//  SHCollectionViewAnimationController.swift
//  SHCollectionviewDemo
//
//  Created by shiheng on 22/7/2020.
//  Copyright © 2020 shiheng. All rights reserved.
//

import UIKit

class SHCollectionViewAnimationController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var itemCount:NSInteger = 10
    var layout: SHCollectionViewAnimationLayout = SHCollectionViewAnimationLayout()
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "com.sh.demo")
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let deleteBtn : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(deleteItem))
        let addBtn : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addItem))
        self.navigationItem.rightBarButtonItems = [deleteBtn,addBtn]
    }

    // MARK: - -- UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "com.sh.demo", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }

    // MARK: - -- UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (screenWidth - 50) / 4, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    // MARK: - -- UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    @objc func deleteItem() {
        
    }
    
    @objc func addItem() {
        collectionView.performBatchUpdates({
            itemCount += 1
            collectionView.insertItems(at: [IndexPath.init(row: itemCount-2, section: 0)])
        }) { (compelet) in
            
        }
    }
}
