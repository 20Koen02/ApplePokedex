//
//  AboutTab.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 18/10/2022.
//

import SwiftUI

struct AboutTab: View {
    let pokemonDetail: PokemonDetail
    
    func getAbilities(abilities: [Ability]) -> String {
        return abilities.map { ability in
            ability.ability.name.replacingOccurrences(of: "-", with: " ").capitalized
        }.joined(separator: ", ")
    }
    
    func getHeld(heldItems: [HeldItem]) -> String {
        return heldItems.map { held in
            held.item.name.replacingOccurrences(of: "-", with: " ").capitalized
        }.joined(separator: ", ")
    }
    
    var body: some View {
        ScrollView {
            Text("About")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(pokemonDetail.types[0].type.name.capitalized))
                .padding(.top, 120)
            
            HStack(spacing: 20) {
                VStack(spacing: 0) {
                    Label(
                        "\(String(Float(pokemonDetail.weight) / 10)) kg",
                        systemImage: "scalemass"
                    )
                    .font(.headline.weight(.light))
                    Text("Weight")
                        .font(.footnote)
                        .fontWeight(.light)
                        .opacity(0.7).padding(.top, 10)
                }
                Divider()
                VStack(spacing: 0) {
                    Label(
                        "\(String(Float(pokemonDetail.height) / 10)) m",
                        systemImage: "arrow.up.and.down"
                    )
                    .font(.headline.weight(.light))
                    Text("Height")
                        .font(.footnote)
                        .fontWeight(.light)
                        .opacity(0.7).padding(.top, 10)
                }
                Divider()
                VStack(spacing: 0) {
                    Label(
                        "\(String(pokemonDetail.baseExperience)) XP",
                        systemImage: "bubbles.and.sparkles"
                    )
                    .font(.headline.weight(.light))
                    Text("Base")
                        .font(.footnote)
                        .fontWeight(.light)
                        .opacity(0.7).padding(.top, 10)
                }
            }.frame(height: 50).padding(.top, 5)
            
            
            if (!pokemonDetail.abilities.isEmpty) {
                Text(pokemonDetail.abilities.count == 1 ? "Ability": "Abilities")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(pokemonDetail.types[0].type.name.capitalized))
                    .padding(.top, 25)
                    .padding(.bottom, 5)
                
                Text(getAbilities(abilities: pokemonDetail.abilities))
                    .font(.headline.weight(.light))
                    .multilineTextAlignment(.center)
            }
            
            if (!pokemonDetail.heldItems.isEmpty) {
                Text(pokemonDetail.heldItems.count == 1 ? "Held Item": "Held Items")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(pokemonDetail.types[0].type.name.capitalized))
                    .padding(.top, 25)
                    .padding(.bottom, 5)
                
                Text(getHeld(heldItems: pokemonDetail.heldItems))
                    .font(.headline.weight(.light))
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
    }
}

struct AboutTab_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemon: PokemonListItem(
                name: "Mankey",
                url: URL(string: "https://pokeapi.co/api/v2/pokemon/56/")!
            ))
        }.environmentObject(PokemonListViewModel())
    }
}
