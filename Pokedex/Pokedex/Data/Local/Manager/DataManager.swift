//
//  DataManager.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation
import RealmSwift
import Combine

public class Storable: Object {
    @Persisted var _aux: String = ""
}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}

protocol DataManager {
    func save<T: DAORepresentable>(object: T) async -> Result<Void, DBError> where T == T.DAOType.DataType
    func saveAll<T: DAORepresentable>(objects: [T]) async -> Result<Void, DBError> where T == T.DAOType.DataType
    func deleteAll<T: DAORepresentable>(_ model: T.Type) async -> Result<Void, DBError> where T == T.DAOType.DataType
    func query<T: DAORepresentable>(_ model: T.Type, predicate: NSPredicate) -> AnyPublisher<T, DBError> where T == T.DAOType.DataType
    func queryAll<T: DAORepresentable>(_ model: T.Type, predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) -> AnyPublisher<[T], DBError> where T == T.DAOType.DataType
    func queryAllWithoutPublisher<T>(_ model: T.Type, predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) -> Result<[T], DBError> where T : DAORepresentable, T == T.DAOType.DataType
}
