//
//  InfiniteGridDataSource.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class InfiniteGridDataSource: NSObject, UICollectionViewDataSource {
    
    let pathsCacheSize: Int = 1024 // arbitrary large number, increase if you use small tile sizes and some cells are not appearing when scrolling
    var pathsCache: [IndexPath : GridCoordinates] = [:]
    var pathsCacheIndex: Int = 0
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pathsCacheSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coordinates = pathsCache[indexPath] ?? GridCoordinates(x: 0, y:0)
        
        return InfiniteGridCell.dequeue(from: collectionView, at: indexPath, for: coordinates)
    }
    
    func assignPath(to coordinates: GridCoordinates) -> IndexPath {
        for cacheEntry in pathsCache where cacheEntry.value == coordinates {
            return cacheEntry.key
        }
        let indexPath = IndexPath(item: pathsCacheIndex, section: 0)
        pathsCacheIndex = (pathsCacheIndex + 1) % pathsCacheSize
        pathsCache[indexPath] = coordinates
        return indexPath
    }
}
