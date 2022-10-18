//
//  GetAllDataService.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import Foundation
import Combine

protocol PokemonListDataService {
    var cancellable: AnyCancellable? { get set }
    func getPokemonListItems(completion: @escaping (Result<[PokemonListItem], RequestError>) -> Void)
}

final class NetworkPokemonListDataService: PokemonListDataService {
    var cancellable: AnyCancellable?
    
    func getPokemonListItems(completion: @escaping (Result<[PokemonListItem], RequestError>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000")!
        let urlRequest = URLRequest(url: url)
        cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map({ $0.data })
            .decode(type: GetAllPokemonsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    case let decodingError as DecodingError:
                        completion(.failure(.decodingError(decodingError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
                }
            }) { (response) in
                completion(.success(response.pokemons))
            }
    }
}
