//
//  FavouritePokemonsView.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import SwiftUI

struct FavouritePokemonsView: View {
    @EnvironmentObject var pokemonFavouriteViewModel: FavouritePokemonsViewModel
  
    var body: some View {
        VStack {
            switch pokemonFavouriteViewModel.getFavouritesPokemonStatus.status {
            case .initial, .loading:
                VStack {
                    Spacer()
                    ProgressView()
                        .frame(height: 50)
                        .foregroundColor(.black)
                    Spacer()
                    Spacer()
                }
            case .success, .outdatedContentError:
                if pokemonFavouriteViewModel.getFavouritesPokemonStatus.pokedex?.count != 0 {
                    VStack {
                        ScrollView {
                            ForEach(pokemonFavouriteViewModel.getFavouritesPokemonStatus.pokedex ?? [], id: \.id) { favouritePokemon in
                                FavouritePokemonCard(name: favouritePokemon.name, image: favouritePokemon.image)
                            }
                        }
                    }
                } else {
                    Text("There's no favourite pokemons yet")
                }
            case .noContentError, .unknownError:
               Text("error")
            }
                
      
        } .onAppear {
            Task {
                await self.pokemonFavouriteViewModel.getAllFavouritePokemons()
            }
        }
    }
}

struct FavouritePokemonsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritePokemonsView()
    }
}
