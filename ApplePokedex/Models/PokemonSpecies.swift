//
//  PokemonSpecies.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 18/10/2022.
//

import Foundation


struct PokemonSpecies: Codable {
    let id: Int
    let evolutionChain: EvolutionChain
    
    enum CodingKeys: String, CodingKey {
        case id
        case evolutionChain = "evolution_chain"
    }
}

struct EvolutionChain: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}
