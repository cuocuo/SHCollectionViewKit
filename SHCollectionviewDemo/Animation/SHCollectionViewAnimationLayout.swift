//
//  SHCollectionViewAnimationLayout.swift
//  SHCollectionviewDemo
//
//  Created by shiheng on 21/7/2020.
//  Copyright © 2020 shiheng. All rights reserved.
//

import UIKit

class SHCollectionViewAnimationLayout: UICollectionViewFlowLayout {
    var updateIndexPaths = NSArray.init()
    
    override func prepare() {
        super.prepare()
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attributes = layoutAttributesForItem(at: itemIndexPath)?.copy() as? UICollectionViewLayoutAttributes {
            if updateIndexPaths.contains(itemIndexPath) {
                attributes.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi).scaledBy(x: 0.2, y: 0.2)
                attributes.center = CGPoint.init(x: collectionView!.bounds.midX, y: collectionView!.bounds.maxY)
                attributes.zIndex = 1
                return attributes
            }
        }
        return nil
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let oldRect = collectionView!.bounds
        if oldRect.equalTo(newBounds) {
            return false
        }
        return true
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        let indexPaths = NSMutableArray.init()
        for item in updateItems {
            switch item.updateAction {
            case UICollectionViewUpdateItem.Action.insert:
                indexPaths.add(item.indexPathAfterUpdate!)
                
            case UICollectionViewUpdateItem.Action.delete:
                indexPaths.add(item.indexPathBeforeUpdate!)
                
            case UICollectionViewUpdateItem.Action.move:
                indexPaths.add(item.indexPathAfterUpdate!)
                indexPaths.add(item.indexPathBeforeUpdate!)
            default:
                print("")
            }
        }
        updateIndexPaths = indexPaths.copy() as! NSArray
        
    }
}
