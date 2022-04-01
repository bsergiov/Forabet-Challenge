//
//  NewGame.swift
//  Forabet Challenge
//
//  Created by SV on 01.04.2022.
//

import Foundation

struct NewGame {
    let sectionGameName: String
    let sectionConditionGame: ConditionGame
}

struct SectionGameName {
    let nameSection: String
}

struct ConditionGame {
    let nameSection: String
    let typeGame: Int
    let discritption: String
}
