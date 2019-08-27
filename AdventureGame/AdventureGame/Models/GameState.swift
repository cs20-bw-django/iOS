//
//  GameState.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/27/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct GameState: Codable {
    let uuid: UUID?
    let name: String?
    let title: String?
    let description: String?
    let players: [Player]?
    let error_msg: String?
}


