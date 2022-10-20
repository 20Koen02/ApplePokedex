//
//  PokemonDetailDataService.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 18/10/2022.
//

import Foundation
import Combine

protocol PokemonDetailDataService {
    var cancellable: AnyCancellable? { get set }
    func getPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, RequestError>) -> Void)
}

final class NetworkPokemonDetailDataService: PokemonDetailDataService {
    var cancellable: AnyCancellable?
    
    func getPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, RequestError>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        let urlRequest = URLRequest(url: url)
        cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map({ $0.data })
            .decode(type: PokemonDetail.self, decoder: JSONDecoder())
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
                completion(.success(response))
            }
    }
}
