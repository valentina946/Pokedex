//
//  FavouritePokemonCard.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import SwiftUI

struct FavouritePokemonCard: View {
    
    let name: String
    let image: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                HStack {
                    VStack(alignment: .leading, spacing: 9) {
                        Text(name)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }.padding(.leading, 20)
                    Spacer()
                }
                AsyncImage(url: URL(string: image)) { image in
                    if let image = image.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
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
            .frame(maxWidth: .infinity)
              
        }
        .background(RoundedRectangle(cornerRadius: 30).fill(Color.gray))  .padding(.horizontal, 20)
    }
}

struct FavouritePokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        FavouritePokemonCard(name: "Bulbasaur", image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png")
    }
}
