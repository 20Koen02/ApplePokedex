//
//  PokemonCard.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import SwiftUI

struct PokemonCard: View {
    let pokemon: PokemonListItem
    
    @EnvironmentObject var viewModel: PokemonListViewModel
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(
                    url: pokemon.imageURL,
                    content: { image in
                        image.interpolation(.none)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 5)
                            .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10))
                    },
                    placeholder: {
                        ProgressView().frame(minHeight: 160)
                    }
                )
                VStack {
                    HStack() {
                        Text(String(format: "%03d", pokemon.id))
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                            .background(Color("AccentColor"))
                            .cornerRadius(4)
                            .foregroundColor(Color("OnAccent"))
                            .padding(10)
                        Spacer()
                        if (viewModel.favoritePokemon.contains(pokemon.id)) {
                            Image(systemName: "heart.fill").padding(10).foregroundColor(Color("AccentColor"))
                        }
                    }
                    Spacer()
                }
            }
            
            HStack {
                Spacer()
                Text(pokemon.name.capitalized)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Spacer()
            }
            .padding()
            .background(Color("SecondaryBackground"))
        }
        .background(Color("AccentContainer"))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contextMenu {
            Button(action: { viewModel.toggleFavorite(pokemon: pokemon) }, label: {
                if (viewModel.favoritePokemon.contains(pokemon.id)) {
                    Label("Remove from Favorites", systemImage: "heart.fill")
                } else {
                    Label("Add to Favorites", systemImage: "heart")
                }
            })
            Button(action: {
                let activityView = UIActivityViewController(activityItems: [pokemon.name.capitalized], applicationActivities: nil)
                
                let allScenes = UIApplication.shared.connectedScenes
                let scene = allScenes.first { $0.activationState == .foregroundActive }
                
                if let windowScene = scene as? UIWindowScene {
                    windowScene.keyWindow?.rootViewController?.present(activityView, animated: true, completion: nil)
                }
            }, label: {
                Label("Share", systemImage: "square.and.arrow.up")
            })
        }
        .shadow(radius: 5)
        .padding(5)
    }
}

struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCard(pokemon: PokemonListItem(
            name: "bulbasaur",
            url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!
        ))
        .environmentObject(PokemonListViewModel())
        .frame(width: 200.0, height: 250.0)
        
    }
}
