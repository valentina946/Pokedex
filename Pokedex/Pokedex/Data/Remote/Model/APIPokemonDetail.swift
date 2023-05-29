//
//  APIPokemonDetail.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation

struct APIPokemonDetail: Codable {
    
    let abilities: [APIAbility]
    let types: [APIType]
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let species: APISpecies
    let sprites: APISprites
    
}

struct APIType: Codable {
    let type: APITypeDetail
}

struct APITypeDetail: Codable {
    let name: String
}


struct APIAbility: Codable {
    let ability: APIAbilityDetail
}

struct APIAbilityDetail: Codable {
    let name: String
}

struct APISprites: Codable {
    let other: APISpritesOther
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        other = try container.decode(APISpritesOther.self, forKey: .other)
        backDefault = try container.decodeIfPresent(String.self, forKey: .backDefault)
        backFemale = try container.decodeIfPresent(String.self, forKey: .backFemale)
        backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
        backShinyFemale = try container.decodeIfPresent(String.self, forKey: .backShinyFemale)
        frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
        frontFemale = try container.decodeIfPresent(String.self, forKey: .frontFemale)
        frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
        frontShinyFemale = try container.decodeIfPresent(String.self, forKey: .frontShinyFemale)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(backFemale, forKey: .backFemale)
        try container.encodeIfPresent(frontDefault, forKey: .frontDefault)
        try container.encodeIfPresent(backDefault, forKey: .backDefault)
        try container.encodeIfPresent(backShiny, forKey: .backShiny)
        try container.encodeIfPresent(backShinyFemale, forKey: .backShinyFemale)
        try container.encodeIfPresent(frontFemale, forKey: .frontFemale)
        try container.encodeIfPresent(frontShiny, forKey: .frontShiny)
        try container.encodeIfPresent(frontShinyFemale, forKey: .frontShinyFemale)
      
    }
    
    enum CodingKeys: String, CodingKey {
  
        case other = "other"
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct APISpritesOther: Codable {
    let home: APISpritesHome
}

struct APISpritesHome: Codable {
    let frontDefault: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = try container.decode(String.self, forKey: .frontDefault)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(frontDefault, forKey: .frontDefault)
    }
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
}

struct APISpecies: Codable {
    let url: String
}


