//
//  CollectionViewBubbleLayout.swift
//  DemoSwift
//
//  Created by mac-0007 on 20/05/17.
//  Copyright © 2017 Jignesh-0007. All rights reserved.
//

import UIKit

protocol CollectionViewBubbleLayoutDelegate {
    func collectionView(collectionView:UICollectionView, itemSizeAtIndexPath indexPath:NSIndexPath) -> CGSize
}

class CollectionViewBubbleLayout: UICollectionViewFlowLayout {
    
    //MARK:-
    
    var cInterItemSpacing:CGFloat?
    var cLineSpacing:CGFloat?
    
    var itemAttributesCache: Array<UICollectionViewLayoutAttributes> = []
    var contentSize:CGSize = CGSize.zero
    var delegate:CollectionViewBubbleLayoutDelegate?
    
    
    
    //MARK:-
    //MARK:- Initialize
    
    override init() {
        super.init()
        
        //...Initialize
        scrollDirection = UICollectionViewScrollDirection.vertical;
        minimumLineSpacing = cLineSpacing ?? 0.0
        minimumInteritemSpacing = cInterItemSpacing ?? 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //...Initialize
        scrollDirection = UICollectionViewScrollDirection.vertical;
        minimumLineSpacing = cLineSpacing ?? 0.0
        minimumInteritemSpacing = cInterItemSpacing ?? 0.0
    }
    
    
    override func prepare() {
        super.prepare()

        if (collectionView?.numberOfSections == 0 ||
            collectionView?.numberOfItems(inSection: 0) == 0) {
            return
        }
        
        itemAttributesCache = []
        
        let numberOfItems:NSInteger = (self.collectionView?.numberOfItems(inSection: 0))!
        
        var x:CGFloat = 0
        var y:CGFloat = 0
        
        var indexPath = NSIndexPath(item: 0, section: 0)
        var iSize:CGSize = CGSize.zero
        
        for index in 0..<numberOfItems {
            indexPath = NSIndexPath(item: index, section: 0)
            iSize = (delegate?.collectionView(collectionView: collectionView!, itemSizeAtIndexPath: indexPath))!
            
            var itemRect:CGRect = CGRect(x: x, y: y, width: iSize.width, height: iSize.height)
            
            if (x > 0 && (x + iSize.width + minimumInteritemSpacing > (collectionView?.frame.size.width)!)) {
                itemRect.origin.x = 0
                itemRect.origin.y = y + iSize.height + minimumLineSpacing
            }
            
            let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            itemAttributes.frame = itemRect
            itemAttributesCache.append(itemAttributes)
            
            x = itemRect.origin.x + iSize.width + minimumInteritemSpacing
            y = itemRect.origin.y
        }
        
        y += iSize.height + self.minimumLineSpacing
        x = 0
        
        contentSize = CGSize(width: (collectionView?.frame.size.width)!, height: y)
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let numberOfItems:NSInteger = (self.collectionView?.numberOfItems(inSection: 0))!
        let itemAttributes = itemAttributesCache.filter {
            $0.frame.intersects(rect) &&
            $0.indexPath.row < numberOfItems
        }
        
        return itemAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributesCache.first {
            $0.indexPath == indexPath
        }
    }
}

