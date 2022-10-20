//
//  PokemonList.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import SwiftUI
import Introspect

struct PokemonList: View {
    let favoritesOnly: Bool
    
    @EnvironmentObject var viewModel: PokemonListViewModel
    @State private var searchText = ""
    @State var uiTabarController: UITabBarController?
    
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]) {
                        ForEach(searchResults) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonCard(pokemon: pokemon)
                            }
                        }
                    }
                    .animation(.default, value: searchResults)
                    .padding()
                }
                .onAppear(perform: viewModel.getPokemonListItems)
                .background(Color("background"))
                .navigationTitle(Text(favoritesOnly ? "Favorites" : "Pokédex"))
                .searchable(text: $searchText,
                            prompt: "Search \(favoritesOnly ? "Favorites" : "Pokédex")")
                .disableAutocorrection(true)
                .refreshable { viewModel.getPokemonListItems() }
                
                if (viewModel.pokemonListError) {
                    Label("Server Error", systemImage: "exclamationmark.circle.fill")
                } else if (searchResults.isEmpty) {
                    if (favoritesOnly && viewModel.favoritePokemon.isEmpty) {
                        Label("No Favorites", systemImage: "heart.slash")
                    } else {
                        ProgressView("Loading")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = false
            uiTabarController = UITabBarController
        }
        
    }
    
    var searchResults: [PokemonListItem] {
        let pokemon = favoritesOnly ? viewModel.favoritePokemonItems : viewModel.pokemonListItems
        if searchText.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
            return pokemon
        } else {
            return pokemon.filter { $0.name.contains(searchText.lowercased()) }
        }
    }
}


struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(favoritesOnly: false).environmentObject(PokemonListViewModel())
    }
}
