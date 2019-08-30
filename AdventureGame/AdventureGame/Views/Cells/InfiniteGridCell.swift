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
    static var roadSet: Set<GridCoordinates> = []
    
    static var playerCoordinates: GridCoordinates?

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
        if let playerPos = playerCoordinates {
            if coordinates == playerPos {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as? RoomCollectionViewCell else { fatalError() }
                cell.backgroundColor = .purple
                
                // add emoji label
                let emoji = UILabel(frame: cell.bounds)
                emoji.text = "🥳"
                emoji.textAlignment = .center
                emoji.font = UIFont(name: "AppleColorEmoji", size: 50)
                cell.backgroundView = emoji
                return cell
            }
        }
        
        if roadSet.contains(coordinates) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as? RoomCollectionViewCell else { fatalError() }
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.9295691252, blue: 0.855507791, alpha: 1)
            cell.backgroundView = nil
            
            
            return cell
        }
        
        if coordinatesSet.contains(coordinates) {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as? RoomCollectionViewCell else { fatalError() }
            cell.backgroundColor = .white
            cell.backgroundView = nil
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? InfiniteGridCell ?? InfiniteGridCell()
            cell.coordinates = coordinates
            cell.backgroundView = nil
            return cell
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layer.borderWidth = 0
        self.backgroundView = nil
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
        label.backgroundColor = #colorLiteral(red: 0.5495000482, green: 0.5495842695, blue: 0.5494885445, alpha: 1)
        
        self.contentView.insertSubview(label, at: 0)
        return label
    }
}
