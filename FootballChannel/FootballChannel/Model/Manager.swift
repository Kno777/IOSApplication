//
//  Manager.swift
//  FootballChannel
//
//  Created by Kno Harutyunyan on 07.07.23.
//

import Foundation

enum JobType {
    case manager, headCoach
}

struct Manager{
    let name: String
    let job: JobType
}
