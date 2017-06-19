//
//  ViewController.swift
//  TestCollectionView
//
//  Created by Calvix on 2017/6/16.
//  Copyright © 2017年 Calvix. All rights reserved.
//

import UIKit

let itemCount = 100

let identifier = "cell"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var contentOffset = CGPoint.zero

    lazy var collectionView: UICollectionView = {
        
        let layout = ScaleCollectionViewLayout()
        layout.itemCount = itemCount
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: layout)
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
//        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        self.collectionView.register(UINib(nibName: "TestCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: identifier)
//        self.collectionView.delegate = CollectionViewDelegate()
        let lastIndex = IndexPath(item: itemCount-1, section: 0)
        self.collectionView.scrollToItem(at: lastIndex, at: .bottom, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TestCollectionViewCell
        cell.titleLabel.text = "\(indexPath.row)"
        let red = CGFloat(arc4random() % 255) / 255.0
        let green = CGFloat(arc4random() % 255) / 255.0
        let blue = CGFloat(arc4random() % 255) / 255.0
   
        cell.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
//        cell.backgroundColor = UIColor.blue
        return cell
    }


}

