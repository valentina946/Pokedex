//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 27/5/23.
//

import SwiftUI

extension PokemonDetailView {
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
    
    var favouriteButton: some View {
        Button(action: {
            
        }) {
            HStack {
                Image(systemName: "heart")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
}

struct PokemonDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let name: String
    let color: String
    let weight: Double
    let height: Double
    let abilities: [String]
    let types: [String]
    let image: String
    let pokemonImages: [String]
  
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 30))
                    .bold()
                HStack {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                            .font(.system(size: 15))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 30).fill(.gray))
                    }
                }
                VStack(spacing: 40) {
                    HStack {
                        CarrouselView(pokemonImages: pokemonImages)
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 30) {
                            Text("Height")
                                .bold()
                            Text("\(height, specifier: "%.2f")")
                        }
                        
                        HStack(spacing: 30) {
                            Text("Weight")
                                .bold()
                            Text("\(weight, specifier: "%.2f")")
                        }
                        
                        HStack {
                            Text("Abilities")
                                .bold()
                            ForEach(abilities, id: \.self) { ability in
                                Text(ability)
                            }
                        }
                        
                    }
                    .font(.system(size: 20))
                    
                    Spacer()
                }
            }.foregroundColor(.white)
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.chooseColor(name: color))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarItems(trailing: favouriteButton)
       
        .background(ignoresSafeAreaEdges: .all)
       
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(name: "Bulbasaur", color: "green", weight: 0.7, height: 6.9, abilities: ["Overgrow", "Chlorophy"],types: ["Grass", "Poison"], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/12.png", pokemonImages: ["https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/female/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/female/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/female/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/female/12.png"])
    }
}
