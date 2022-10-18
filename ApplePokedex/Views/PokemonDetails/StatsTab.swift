//
//  StatsTab.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 18/10/2022.
//

import SwiftUI

struct StatsTab: View {
    let pokemonDetail: PokemonDetail
    private let stats = ["HP", "Attack", "Degense", "Sp. Atk", "Sp. Def", "Speed"]
    
    var body: some View {
        ScrollView {
            Text("Stats")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(pokemonDetail.types[0].type.name.capitalized))
                .padding(.top, 120)
            
            HStack(spacing: 15){
                VStack(alignment: .trailing, spacing: 3) {
                    ForEach(stats, id: \.self) { stat in
                        Text(stat)
                            .fontWeight(.bold)
                            .foregroundColor(Color(pokemonDetail.types[0].type.name.capitalized))
                    }
                }
                Divider()
                VStack(spacing: 3) {
                    ForEach(pokemonDetail.stats, id: \.stat.name) { stat in
                        HStack {
                            Text(String(format: "%03d", stat.baseStat))
                                .font(.system(.body, design: .monospaced))
                            ProgressView(value: Float(stat.baseStat), total: 255)
                                .tint(Color(pokemonDetail.types[0].type.name.capitalized))
                                .background(Color(pokemonDetail.types[0].type.name.capitalized).opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                                .scaleEffect(x: 1, y: 1.5, anchor: .center)
                                .padding(0)
                                .padding(.trailing, 10)
                        }
                    }
                }
            }
            .frame(maxWidth: 500)
            .frame(height: 135)
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Spacer()
        }
    }
}

struct StatsTab_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemon: PokemonListItem(
                name: "Mankey",
                url: URL(string: "https://pokeapi.co/api/v2/pokemon/56/")!
            ), selection: 1)
        }.environmentObject(PokemonListViewModel())
    }
}
