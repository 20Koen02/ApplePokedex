//
//  PokemonDetailViewModel.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 18/10/2022.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail? = nil
    @Published var pokemonDetailError = false

    let dataService: PokemonDetailDataService
    
    init(dataService: PokemonDetailDataService = NetworkPokemonDetailDataService()) {
        self.dataService = dataService
    }
    
    func getPokemonDetail(id: Int) {
        pokemonDetail = nil
        pokemonDetailError = false
        dataService.getPokemonDetail(id: id, completion: {
            [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemonDetail = pokemons
            case .failure(_):
                self?.pokemonDetailError = true
            }
        })
    }
    
    func configure(with something: Any) {}
}
