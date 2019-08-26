//
//  InfiniteGridLayout.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class InfiniteGridLayout: UICollectionViewLayout {
    
    let gridSize = CGSize(width: 10000, height: 10000) // arbitrary grid size
    let tileSize = CGSize(width: 100, height: 100)     // arbitrary tile size
    
    override var collectionViewContentSize: CGSize {
        return gridSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // ignore rect for now, just return one cell at center of the grid
        let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 0, section: 0))
        itemAttributes.frame = CGRect(x: (gridSize.width - tileSize.width) * 0.5, y: (gridSize.height - tileSize.height) * 0.5, width: tileSize.width, height: tileSize.height)
        return [itemAttributes]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        // Not supported
        return nil
    }
}
