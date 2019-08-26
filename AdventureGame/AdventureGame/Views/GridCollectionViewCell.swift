//
//  GridCollectionViewCell.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class InfiniteGridCell: UICollectionViewCell {
    
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
                        for coordinates: GridCoordinates) -> InfiniteGridCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? InfiniteGridCell ?? InfiniteGridCell()
        cell.coordinates = coordinates
        return cell
    }
    
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
        
        label.layer.borderWidth = 3.0
        label.layer.borderColor = #colorLiteral(red: 0.2192418128, green: 0.5473350286, blue: 0.9997488856, alpha: 1)
        
        self.contentView.addSubview(label)
        return label
    }
}
