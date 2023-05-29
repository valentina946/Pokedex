//
//  PokemonCard.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 25/5/23.
//

import SwiftUI

struct PokemonCard: View {
    let name: String
    let types: [String]
    let image: String
    let color: String
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                HStack {
                    VStack(alignment: .leading, spacing: 9) {
                        Text(name)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        VStack(spacing: 7) {
                            ForEach(types, id: \.self) { type in
                                Text(type)
                                    .font(.system(size: 15))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(.white)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(.gray))
                            }
                        }
                        
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
            } .frame(maxWidth: UIScreen.main.bounds.width / 2)
        }
        .padding(.top, 20)
        .padding(.bottom, 10)
        .background(RoundedRectangle(cornerRadius: 30).fill(Color.chooseColor(name: color)))
    }
}

struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCard(name: "bulbasaur", types: ["grass", "poison"], image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/12.png", color: "green")
    }
}
