//
//  PokedexView.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 19/5/23.
//

import SwiftUI
import Factory
import AlertToast

struct PokedexView: View {
    
    @InjectedObject(\.pokedexViewModel) var pokedexViewModel
    @InjectedObject(\.FavouritePokemonViewModel) var favouritePokemonViewModel
    @State var boolean = false
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
                                    PokemonDetailView(id: pokemon.id, name: pokemon.name, color: pokemon.color, weight: pokemon.weight, height: pokemon.heigth, abilities: pokemon.ability, types: pokemon.types, image: pokemon.image, pokemonImages: pokemon.imagesCarrousel)
                                        .environmentObject(favouritePokemonViewModel)
                                } label: {
                                    PokemonCard(name: pokemon.name, types: pokemon.types, image: pokemon.image, color: pokemon.color)
                                }
                            }
                        }
                    }
                    
                }
                HStack {
                    Button {
                        Task {
                            await pokedexViewModel.getAllPokemon(isNextPress: false)
                        }
                    } label: {
                        Image(systemName: "arrowshape.backward.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height:  50)
                    }
                    
                    NavigationLink {
                        FavouritePokemonsView()
                            .environmentObject(favouritePokemonViewModel)
                    } label: {
                        Text("View favourite pokemons")
                    }
                    
                    Button {
                        Task {
                            await pokedexViewModel.getAllPokemon(isNextPress: true)
                        }
                    } label: {
                        Image(systemName: "arrowshape.forward.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height:  50)
                    }
                    
                }  .padding(.horizontal, 20)
                
            }
            .onChange(of: pokedexViewModel.pokemonNamesState.status, perform: { newValue in
                if newValue == .noContentError {
                    self.boolean.toggle()
                }
            })
            .toast(isPresenting: $boolean) {
                AlertToast(displayMode: .hud, type: .regular, title: "Connection Error")
            }
        }
    }
    
}


struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
