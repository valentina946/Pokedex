//
//  DAOPokemonDetail.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 26/5/23.
//

import Foundation
import RealmSwift

final class DAOPokemonDetail: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var ability: RealmSwift.List<String>
    @Persisted var types: RealmSwift.List<String>
    @Persisted var height: Double
    @Persisted var weight: Double
    @Persisted var species: String
    @Persisted var color: String?
    @Persisted var image: String
    @Persisted var imagesCarrousel: RealmSwift.List<String>
    
    convenience init(id: Int, name: String, ability: [String], types: [String], height: Double, weight: Double, species: String, color: String?, image: String, imagesCarrousel: [String]) {
        self.init()
        self.id = id
        self.name = name
        self.ability.append(objectsIn: ability)
        self.types.append(objectsIn: types)
        self.height = height
        self.weight = weight
        self.species = species
        self.color = color
        self.image = image
        self.imagesCarrousel.append(objectsIn: imagesCarrousel)
    }

}

extension DAOPokemonDetail: DataRepresentable {
    
    func toData() -> DBPokemonDetails {
        return DBPokemonDetails(id: self.id, abilities: self.ability.map {$0}, types: self.types.map {$0}, name: self.name, height: self.height, weight: self.weight, species: species, color: color, image: image, imagesCarrousel: self.imagesCarrousel.map {$0})
        
    }
}
    
    extension DBPokemonDetails: DAORepresentable {
        
        func toDAO() -> DAOPokemonDetail { return DAOPokemonDetail(id: self.id, name: self.name, ability: self.abilities, types: types, height: self.height, weight: self.weight, species: species, color: color, image: image, imagesCarrousel: self.imagesCarrousel) }
        
    }

