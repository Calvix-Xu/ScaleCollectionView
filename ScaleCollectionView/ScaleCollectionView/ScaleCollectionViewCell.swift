//
//  ScaleCollectionViewCell.swift
//  TestCollectionView
//
//  Created by Calvix on 2017/6/20.
//  Copyright © 2017年 Calvix. All rights reserved.
//

import UIKit

open class ScaleCollectionViewCell: UICollectionViewCell {
    
    //防止后一个cell不会被前一个cell遮挡
    override open func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        superview?.bringSubview(toFront: self)
        super.apply(layoutAttributes)
    }
    
}
