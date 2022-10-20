//
//  ContentView.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: PokemonListViewModel

    init(viewModel: PokemonListViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        TabView {
            PokemonList(favoritesOnly: false)
                .tabItem {
                    Label("Pokémon", image: "pokeball.fill")
                }
            
            PokemonList(favoritesOnly: true)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
        .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
