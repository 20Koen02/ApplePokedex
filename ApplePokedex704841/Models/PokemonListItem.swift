//
//  GetAllPokemon.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import Foundation


struct GetAllPokemonsResponse: Decodable {
    let pokemons: [PokemonListItem]
    enum CodingKeys: String, CodingKey {
        case pokemons = "results"
    }
}


struct PokemonListItem: Decodable, Identifiable, Equatable {
    let name: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
    
    var id: Int {
        get { Int(
            url.absoluteString
                .replacingOccurrences(of: "v2", with: "")
                .components(separatedBy: CharacterSet.decimalDigits.inverted)
                .joined()
        )! }
    }
    
    var imageURL: URL {
        get { URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")! }
    }
}
