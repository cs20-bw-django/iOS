//
//  GameState.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/27/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct GameState: Codable {
    let uuid: String?
    let name: String?
    let title: String?
    let description: String?
    let players: [String]?
    let error_msg: String?
}


