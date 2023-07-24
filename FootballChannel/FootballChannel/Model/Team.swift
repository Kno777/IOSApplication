//
//  Team.swift
//  FootballChannel
//
//  Created by Kno Harutyunyan on 07.07.23.
//

import Foundation

class Team {
    let id: TeamType
    let name: String
    let info: String
    let founded: String
    let manager: Manager
    var isPlaying: Bool
    
    init(id: TeamType, name: String, info: String, founded: String, manager: Manager, isPlaying: Bool = false) {
        self.id = id
        self.name = name
        self.info = info
        self.founded = founded
        self.manager = manager
        self.isPlaying = isPlaying
    }
}
