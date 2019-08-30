//
//  GridCollectionViewCell.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class InfiniteGridCell: UICollectionViewCell {
    
    static var coordinatesSet: Set<GridCoordinates> = []
    
    
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
        if coordinatesSet.contains(coordinates) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as? RoomCollectionViewCell else { fatalError() }
            cell.backgroundColor = .white
            cell.layer.borderColor = #colorLiteral(red: 0.1311326623, green: 0.3781063557, blue: 0.6658913493, alpha: 1)
            cell.layer.borderWidth = 3.0
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? InfiniteGridCell ?? InfiniteGridCell()
            cell.coordinates = coordinates
            
            return cell
        }
        
        //return UICollectionViewCell()
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
        
        label.layer.borderWidth = 0.5
        label.layer.borderColor = #colorLiteral(red: 0.3330089152, green: 0.333286792, blue: 0.3330519199, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.5455184579, green: 0.5459486246, blue: 0.5455850959, alpha: 1)
        
        self.contentView.addSubview(label)
        return label
    }
}
