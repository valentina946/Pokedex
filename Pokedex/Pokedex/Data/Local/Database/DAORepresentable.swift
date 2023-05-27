//
//  DAORepresentable.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 26/5/23.
//

import Foundation
import RealmSwift

protocol DAORepresentable {
    
    associatedtype DAOType: DataRepresentable, Object
    
    func toDAO() -> DAOType
    
}

protocol DAEORepresentable {
    
    associatedtype DAOType: DataRepresentable, EmbeddedObject
    
    func toDAO() -> DAOType
    
}

protocol DataRepresentable {
    
    associatedtype DataType
    
    func toData() throws -> DataType
    
}
