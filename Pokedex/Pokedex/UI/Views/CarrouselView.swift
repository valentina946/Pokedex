//
//  CarrouselView.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 27/5/23.
//

import SwiftUI

struct CarrouselView: View {
    @State private var index = 0
    let pokemonImages: [String]
    var body: some View {
        VStack {
            
            TabView(selection: $index) {
                ForEach(0..<pokemonImages.count, id: \.self) { index in
                    CardView(pokemonImage: pokemonImages[index])
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: 200, maxHeight: 200)
            HStack(spacing: 2) {
                ForEach(0..<pokemonImages.count, id: \.self) { index in
                    Rectangle()
                        .fill(index == self.index ? Color.purple : Color.purple.opacity(0.5))
                        .frame(width: 30, height: 5)
                    
                }
            }
            .padding()
            
        }
    }
}

struct CardView: View {
    let pokemonImage: String
    var body: some View {
        
        AsyncImage(url: URL(string: pokemonImage)) { image in
            if let image = image.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 200, maxHeight: 200)
            } else if image.error != nil {
                Image(systemName: "photo.fill")
                    .padding(.trailing, 30)
               
            } else {
                ProgressView()
                    .font(.largeTitle)
                    .padding(.trailing, 30)
            }
            
        }
    }
}

struct CarrouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarrouselView(pokemonImages: ["https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/female/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/female/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/female/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/12.png", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/female/12.png"])
    }
}
