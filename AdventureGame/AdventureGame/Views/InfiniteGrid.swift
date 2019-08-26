//
//  InfiniteGrid.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class InfiniteGrid: UICollectionView {
    
    let infiniteDataSource = InfiniteGridDataSource()
    var centerCoordinates = GridCoordinates(x: 0, y: 0) {
        didSet {
            self.reloadData()
        }
    }

    
    convenience init(hostView: UIView) {
        self.init(frame: hostView.bounds, collectionViewLayout: InfiniteGridLayout())
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = true
        self.backgroundColor = UIColor.clear
        
        self.dataSource = infiniteDataSource
        InfiniteGridCell.register(with: self)
        
        hostView.addSubview(self)
    }
    
    func scrollToCenter() {
        let size = self.contentSize
        let topLeftCoordinatesWhenCentered = CGPoint(x: (size.width - self.frame.width) * 0.5,
                                                     y: (size.height - self.frame.height) * 0.5)
        self.setContentOffset(topLeftCoordinatesWhenCentered, animated: false)
    }
}
