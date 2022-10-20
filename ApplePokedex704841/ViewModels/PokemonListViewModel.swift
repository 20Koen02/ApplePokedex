//
//  PokemonListViewModel.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemonListItems = [PokemonListItem]()
    @Published var favoritePokemon: Set<Int> = []
    @Published var pokemonListError = false
    
    let dataService: PokemonListDataService
    private let userStore = UserStore()
    
    init(dataService: PokemonListDataService = NetworkPokemonListDataService()) {
        self.dataService = dataService
        self.favoritePokemon = userStore.loadFavorites()
    }
    
    func configure(with something: Any) {}
    
    func getPokemonListItems() {
        pokemonListError = false
        dataService.getPokemonListItems { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemonListItems = pokemons
            case .failure(_):
                self?.pokemonListError = true
            }
        }
    }
    
    var favoritePokemonItems: [PokemonListItem] {
        return pokemonListItems.filter { favoritePokemon.contains($0.id) }
    }
    
    func isFavorite(pokemon: PokemonListItem) -> Bool {
        return favoritePokemon.contains(pokemon.id)
    }
    
    func toggleFavorite(pokemon: PokemonListItem) {
        if favoritePokemon.contains(pokemon.id) {
            favoritePokemon.remove(pokemon.id)
        } else {
            favoritePokemon.insert(pokemon.id)
        }
        userStore.setFavorites(items: favoritePokemon)
    }
}
