//
//  PokedexRemoteDataSourceImpl.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation
import Alamofire

struct PokedexRemoteDataSourceImpl: PokedexRemoteDataSource {
    
    private func makeGetRequest(url: String, parameters: Parameters?) async -> Result<Data, APIError> {
        return await withCheckedContinuation { continuation in
            AF.request(url, method: .get, parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                                continuation.resume(returning: .success(jsonData))
                            }
                        } catch(let error) {
                            continuation.resume(returning: .failure(error as? APIError ?? APIError.unknown(description: error.localizedDescription)))
                        }
                        
                    case .failure(let error):
                        continuation.resume(returning: .failure(APIError.unknown(description: error.localizedDescription)))
                    }
                }
        }
    }
    
    private func getPokemonColor(urlColor: String) async -> Result<String, APIError> {
        let makeGetRequest = await makeGetRequest(url: urlColor, parameters: nil)
        switch makeGetRequest {
        case .success(let success):
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let pokemon = try decoder.decode(APISpeciesDetail.self, from: success)
                return .success(pokemon.color.name)
            } catch(let error) {
                return .failure(error as? APIError ?? APIError.unknown(description: error.localizedDescription))
            }
            
        case .failure(let error):
            return .failure(error as? APIError ?? APIError.unknown(description: error.localizedDescription))
        }
    }
    
    private func fetchPokemonsDetails(pokedex: APIPokedex) async -> Result<[PokemonDetail], APIError> {
        var apiPokex: [PokemonDetail] = []
        for pokemon in pokedex.results {
            let makeGetRequest = await makeGetRequest(url: pokemon.url, parameters: nil)
            switch makeGetRequest {
            case .success(let data):
                let decoder = JSONDecoder()
            //    decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    
                    let pokemon = try decoder.decode(APIPokemonDetail.self, from: data)
                    let getPokemonColor = await getPokemonColor(urlColor: pokemon.species.url)
                    switch getPokemonColor {
                    case .success(let success):
                        var pokemonDetail = PokemonDetail(apiPokemonDetail: pokemon)
                        pokemonDetail.color = success
                        apiPokex.append(pokemonDetail)
                        
                    case .failure(let failure):
                        return .failure(failure as? APIError ?? APIError.unknown(description: failure.localizedDescription))
                    }
                    
                } catch(let error) {
                    return .failure(error as? APIError ?? APIError.unknown(description: error.localizedDescription))
                }
            case .failure(let failure):
                return .failure(failure)
            }
        }
        return .success(apiPokex)
    }
    
    func getAllPokemons(offset: Int, limit: Int) async -> Result<[PokemonDetail], APIError> {
       // let url = "\(Constants.Data.BASE_URL)"
//        let params: Parameters = [
//            "limit": limit,
//            "offset": offset
//        ]
        let makeGetRequest = await makeGetRequest(url: Constants.Data.currentURL, parameters: nil)
        switch makeGetRequest {
        case .success(let data):
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let pokemon = try decoder.decode(APIPokedex.self, from: data)
                Constants.Data.currentURL = pokemon.next ?? ""
                let fetchPokemonDetails = await fetchPokemonsDetails(pokedex: pokemon)
                switch fetchPokemonDetails {
                case .success(let success):
                    return .success(success)
                case .failure(let failure):
                    return .failure(failure as? APIError ?? APIError.unknown(description: failure.localizedDescription))
                }
                
            } catch(let error) {
                return .failure(error as? APIError ?? APIError.unknown(description: error.localizedDescription))
            }
        case .failure(let failure):
            return .failure(failure)
            
        }
    }
    
}

