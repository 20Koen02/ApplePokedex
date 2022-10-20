//
//  PokemonDetailView.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 13/10/2022.
//

import SwiftUI
import Introspect
import CachedAsyncImage

struct PokemonDetailView: View {
    let pokemon: PokemonListItem
    @EnvironmentObject var listViewModel: PokemonListViewModel
    @State var uiTabarController: UITabBarController?
    
    @StateObject var viewModel: PokemonDetailViewModel
    
    @State var selection: Int
    
    init(pokemon: PokemonListItem, selection: Int = 0, viewModel: PokemonDetailViewModel = .init()) {
        self.pokemon = pokemon
        _viewModel = StateObject(wrappedValue: viewModel)
        _selection = State(initialValue: selection)
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("AccentColor"))
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(Color("onBackground").opacity(0.8))
                            .padding(.leading, 20)
                        Spacer()
                        Text(String(format: "#%03d", pokemon.id))
                            .font(.title2.weight(.light))
                            .foregroundColor(Color("onBackground").opacity(0.8))
                            .padding(.trailing, 20)
                    }
                    HStack {
                        if (viewModel.pokemonDetail != nil) {
                            ForEach(viewModel.pokemonDetail!.types, id: \.slot) { type in
                                Text(type.type.name.capitalized)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                                    .background(Color(type.type.name.capitalized))
                                    .cornerRadius(.infinity)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                    }.padding(.leading, 20).padding(.top, 5)
                    Spacer()
                }
                
                CachedAsyncImage(
                    url: pokemon.imageURL,
                    content: { image in
                        image.interpolation(.none)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 5, y: 10)
                            .frame(height: 280)
                    },
                    placeholder: {
                        ProgressView().frame(height: 250)
                    }
                )
                
            }
            .frame(height: 420)
            .zIndex(1)
            
            VStack {
                if (viewModel.pokemonDetail != nil) {
                    TabView(selection:$selection) {
                        // MARK: - About
                        AboutTab(pokemonDetail: viewModel.pokemonDetail!).tag(0)
                        
                        // MARK: - Stats
                        StatsTab(pokemonDetail: viewModel.pokemonDetail!).tag(1)
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .padding(.bottom, 10)
                } else if (viewModel.pokemonDetailError) {
                    Label("Server Error", systemImage: "exclamationmark.circle.fill")
                } else {
                    ProgressView("Loading")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("background"))
            .cornerRadius(40, corners: [.topLeft, .topRight])
            .offset(y: -200)
            .padding(.bottom, -200)
            .zIndex(0)
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear { viewModel.getPokemonDetail(id: pokemon.id) }
        .navigationBarTitleDisplayMode(.inline)
        .background (
            viewModel.pokemonDetail != nil ?
            Color(viewModel.pokemonDetail!.types[0].type.name.capitalized).opacity(0.5) : Color("AccentContainer")
        )
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    let activityView = UIActivityViewController(activityItems: [pokemon.name.capitalized], applicationActivities: nil)
                    
                    let allScenes = UIApplication.shared.connectedScenes
                    let scene = allScenes.first { $0.activationState == .foregroundActive }
                    
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.keyWindow?.rootViewController?.present(activityView, animated: true, completion: nil)
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
                Button(action: {
                    listViewModel.toggleFavorite(pokemon: pokemon)
                }) {
                    Image(systemName: listViewModel.isFavorite(pokemon: pokemon) ? "heart.fill" : "heart")
                }
            }
        }
        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = true
            uiTabarController = UITabBarController
        }
        .environmentObject(viewModel)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemon: PokemonListItem(
                name: "Charizard",
                url: URL(string: "https://pokeapi.co/api/v2/pokemon/6/")!
            ))
        }.environmentObject(PokemonListViewModel())
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
