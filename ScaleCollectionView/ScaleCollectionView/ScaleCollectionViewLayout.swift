//
//  ScaleCollectionViewLayout.swift
//  TestCollectionView
//
//  Created by Calvix on 2017/6/20.
//  Copyright © 2017年 Calvix. All rights reserved.
//

import UIKit

open class ScaleCollectionViewLayout: UICollectionViewLayout {
    
    public var itemHeight: CGFloat = 420.0      // item高度
    public var itemCoverPercent: CGFloat = 0.8  //下一个item覆盖前一个item的百分比
    public var itemCount: Int  = 0              //item数量
    public var firstItemscaleWidth: CGFloat = 80  //第一个item缩进的宽度，设置了第一个，其他的item根据第一个来缩放
    
    override open var collectionViewContentSize: CGSize{
        let width = CGFloat(self.collectionView?.frame.size.width ?? 0)
        var height = CGFloat(itemHeight) + CGFloat(itemCount-1)*CGFloat(itemHeight)*CGFloat(1-itemCoverPercent)
        if height <= self.collectionView!.frame.size.height {
            height = self.collectionView!.frame.size.height + 10
        }
        return CGSize(width: width, height: height)
    }
    
  
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        let indexs = visiableIndexPathsIn(rect)
        let maxVisibleY = self.collectionView!.contentOffset.y + self.collectionView!.frame.size.height
        var attributes = indexs.map {
                layoutAttributesForItem(at: $0)
            }
            .flatMap {
                $0
            }
        //item数量不足于填充整个界面时的处理
        if self.collectionViewContentSize.height <= self.collectionView!.frame.size.height + 10 {
            attributes = attributes.reversed().enumerated().map { (index, element) in
                var frame = element.frame
                frame.origin = CGPoint(x: 0, y: self.collectionView!.frame.size.height - CGFloat(itemHeight) - CGFloat(itemHeight) * (1 - itemCoverPercent) * CGFloat(index))
                element.frame = frame
                return element
            }
        }
        
        let array = attributes.enumerated().map { (index, element) -> UICollectionViewLayoutAttributes? in
                let attr = element
 
                let scaleX: CGFloat = 1 - (firstItemscaleWidth / self.collectionView!.frame.size.width) *  (maxVisibleY - attr.frame.midY) / self.collectionView!.frame.size.height
                let scaleY: CGFloat = 1 +  1 * (maxVisibleY - attr.frame.midY) / self.collectionView!.frame.size.height
        
                attr.transform = CGAffineTransform(scaleX: scaleX, y: 1)
                let power = itemCoverPercent * 10
                let newY =  pow(2.0-scaleY+0.2, power) * CGFloat(itemHeight)*itemCoverPercent + attr.center.y
            
                attr.center = CGPoint(x: attr.center.x, y: newY)
            
                return attr
            }
            .flatMap {
                $0
            }
        return array
    }
    
    //TODO:todo
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let width: CGFloat = self.collectionView?.frame.width ?? 0
        attribute.frame = CGRect(x: 0.0, y: CGFloat(itemHeight) * (1-itemCoverPercent) * (CGFloat(indexPath.row)), width: width, height: CGFloat(itemHeight))

        return attribute
    }
    
    func visiableIndexPathsIn(_ rect: CGRect) -> [IndexPath] {
        let array: [IndexPath]
        let minVisibleY = self.collectionView!.contentOffset.y - CGFloat(itemHeight)
        let maxVisibleY = self.collectionView!.contentOffset.y + self.collectionView!.frame.size.height + CGFloat(itemHeight) * CGFloat(1 - itemCoverPercent)
        array = (0..<itemCount).filter {
            let y = CGFloat(CGFloat($0) * (CGFloat(itemHeight)*(1-itemCoverPercent)))
            return y >= minVisibleY && y <= maxVisibleY
            }
            .map {
                IndexPath(item: $0, section: 0)
        }
        
        return array
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
