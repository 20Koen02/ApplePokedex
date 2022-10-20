//
//  PokemonDetail.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 18/10/2022.
//

import Foundation


// MARK: - PokemonDetail
struct PokemonDetail: Codable {
    let abilities: [Ability]
    let baseExperience: Int
    let forms: [NameUrl]
    let gameIndices: [GameIndex]
    let height: Int
    let heldItems: [HeldItem]
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let moves: [Move]
    let name: String
    let order: Int
    let species: NameUrl
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order
        case species, stats, types, weight
    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: NameUrl
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct NameUrl: Codable {
    let name: String
    let url: String
}

// MARK: - GameIndex
struct GameIndex: Codable {
    let gameIndex: Int
    let version: NameUrl
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - HeldItem
struct HeldItem: Codable {
    let item: NameUrl

    enum CodingKeys: String, CodingKey {
        case item
    }
}

// MARK: - Move
struct Move: Codable {
    let move: NameUrl
    let versionGroupDetails: [VersionGroupDetail]
    
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod, versionGroup: NameUrl
    
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: NameUrl
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: NameUrl
}
