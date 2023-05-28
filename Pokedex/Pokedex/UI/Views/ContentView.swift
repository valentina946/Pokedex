//
//  ContentView.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 19/5/23.
//

import SwiftUI
import Factory

struct ContentView: View {
    
    @InjectedObject(\.pokedexViewModel) var pokedexViewModel
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 200)), count: 2)
    }
    private var columns: [GridItem] = [
        GridItem(.fixed(180), spacing: 16),
        GridItem(.fixed(180), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    let pokemonsDetail = pokedexViewModel.pokemonNamesState.pokedex
                    ScrollView {
                        LazyVGrid(
                            columns: columns,
                            alignment: .center,
                            spacing: 16,
                            pinnedViews: [.sectionHeaders, .sectionFooters]
                        ) {
                            ForEach(pokemonsDetail ?? [], id: \.self) { pokemon in
                                NavigationLink {
                                    PokemonDetailView(name: pokemon.name, color: pokemon.color, weight: pokemon.weight, height: pokemon.heigth, abilities: pokemon.ability, types: pokemon.types, image: pokemon.image, pokemonImages: pokemon.imagesCarrousel)
                                } label: {
                                    PokemonCard(name: pokemon.name, types: pokemon.types, image: pokemon.image, color: pokemon.color)
                                }
                            }
                        }
                    }
                    
                }//.padding(.bottom, 50)
                HStack {
                    if pokedexViewModel.offset != 0 {
                        Button {
                        Task {
                            pokedexViewModel.offset  = pokedexViewModel.offset - 10
                            await pokedexViewModel.getAllPokemon()
                        }
                    } label: {
                        Image(systemName: "arrowshape.backward.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height:  50)
                    }
                }
                    Spacer()
                    Button {
                        Task {
                            await pokedexViewModel.getAllPokemon()
                        }
                    } label: {
                        Image(systemName: "arrowshape.forward.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height:  50)
                    }
                  
                }  .padding(.horizontal, 20)
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
