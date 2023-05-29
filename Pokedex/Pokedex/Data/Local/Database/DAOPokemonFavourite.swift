//
//  DAOPokemonFavourite.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import Foundation
import RealmSwift

final class DAOPokemonFavourite: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var imagesCarrousel: RealmSwift.List<String>
    
    convenience init(id: Int, name: String, image: String) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
    }
    
}

extension DAOPokemonFavourite: DataRepresentable {
    
    func toData() -> DBFavouritePokemon {
        return DBFavouritePokemon(id: self.id, name: self.name, image: self.image)
        
    }
}

extension DBFavouritePokemon: DAORepresentable {
    
    func toDAO() -> DAOPokemonFavourite {
        return DAOPokemonFavourite(id: self.id, name: self.name, image: self.image)
        
    }
    
}

