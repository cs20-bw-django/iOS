//
//  GridCollectionViewCell.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class InfiniteGridCell: UICollectionViewCell {
    
    static var coordinatesArray: [GridCoordinates] = []
    
    
    private(set) var coordinates = GridCoordinates(x: 0, y: 0) {
        didSet {
            coordinatesLabel().text = "\(coordinates.x), \(coordinates.y)"
        }
    }
    
    static let identifier = "InfiniteGridCell"
    static func register(with collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: identifier)
    }
    
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath,
                        for coordinates: GridCoordinates) -> UICollectionViewCell {
        if !coordinatesArray.contains(coordinates){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? InfiniteGridCell ?? InfiniteGridCell()
            cell.coordinates = coordinates
            return cell
        }
        
        if coordinatesArray.contains(coordinates) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as? RoomCollectionViewCell
            cell!.layer.borderWidth = 30
            cell!.layer.borderColor = #colorLiteral(red: 0.8590026498, green: 0.9080110788, blue: 0.9488238692, alpha: 1)
            return cell!
        }
        return UICollectionViewCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layer.borderWidth = 0
    }
    
//    private func roomLabel() -> UILabel {
//        return
//    }
    
    private func coordinatesLabel( ) -> UILabel {
        
        
        
        if let label = self.contentView.subviews.first as? UILabel {
            return label
        }
        
        let label = UILabel(frame: self.contentView.bounds)
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        label.translatesAutoresizingMaskIntoConstraints = true
        
        label.layer.borderWidth = 6.0
        label.layer.borderColor = #colorLiteral(red: 0.07691047341, green: 0.0657993257, blue: 0.1335668266, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.5455184579, green: 0.5459486246, blue: 0.5455850959, alpha: 1)
        
        self.contentView.addSubview(label)
        return label
    }
}
