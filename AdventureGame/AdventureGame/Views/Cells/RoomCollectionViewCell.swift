//
//  RoomCollectionViewCell.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/26/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class RoomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RoomCell"
    static func register(with collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: identifier)
    }
    
}
