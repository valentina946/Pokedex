//
//  DataManagerImpl.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation
import RealmSwift
import Combine

class DataManagerImpl {
    private let queue = DispatchQueue(label: "background queue")
    private var configuration: Realm.Configuration
    private var realm: Realm!
    
    private var operationQueue: OperationQueue {
        let operationQueue = OperationQueue()
        operationQueue.underlyingQueue = queue
        return operationQueue
    }
    
    init() {
        configuration = Realm.Configuration(schemaVersion: 0, deleteRealmIfMigrationNeeded: true)
        queue.sync {
            self.realm = try? Realm(configuration: self.configuration, queue: self.queue)
            if let url = realm.configuration.fileURL {
                print("Realm path url ->", url)
            }
        }
    }
}

extension DataManagerImpl: DataManager {
    func queryAll<T>(_ model: T.Type, predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) -> AnyPublisher<[T], DBError> where T : DAORepresentable, T == T.DAOType.DataType {
        let realm = try! Realm(configuration: configuration)
        realm.refresh()
        var result = realm.objects(model.DAOType)
        if let predicate = predicate {
            result = result.filter(predicate)
        }
        if let sortDescriptor = sortDescriptor {
            result = result.sorted(byKeyPath: sortDescriptor.key ?? "", ascending: sortDescriptor.ascending)
        }
        return result
            .collectionPublisher
            .subscribe(on: queue)
            .freeze()
            .tryMap { Array( try $0.map { try $0.toData() }) }
            .mapError({ error in
                DBError(error: error)
            })
            .eraseToAnyPublisher()
    }
    
    func queryAllWithoutPublisher<T>(_ model: T.Type, predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) -> Result<[T], DBError> where T : DAORepresentable, T == T.DAOType.DataType {
            let realm = try! Realm(configuration: configuration)
            realm.refresh()
            var result = realm.objects(model.DAOType)
            do {
                return .success(Array( try result.map { try $0.toData() }))
            }
            catch(let error) {
                return .failure(DBError(error: error))
            }
    }
    
    
    func saveAll<T: DAORepresentable>(objects: [T]) async -> Result<Void, DBError> where T == T.DAOType.DataType {
        do {
            try await withCheckedThrowingContinuation({ continuation in
                operationQueue.addOperation {
                    do {
                        try self.realm.write {
                            self.realm.add(objects.map { $0.toDAO() }, update: .modified)
                            continuation.resume()
                        }
                    } catch(let error) {
                        continuation.resume(throwing: DBError(error: error))
                    }
                }
            })
            return .success(())
        } catch(let error) {
            return .failure(DBError(error: error))
        }
    }
    
    func query<T: DAORepresentable>(_ model: T.Type, predicate: NSPredicate) -> AnyPublisher<T, DBError> where T == T.DAOType.DataType {
        let realm = try! Realm(configuration: configuration)
        let result = realm.objects(model.DAOType)
            .filter(predicate)
        realm.refresh()
        return result
            .collectionPublisher
            .subscribe(on: queue)
            .freeze()
            .tryMap {
                if let result = try $0.first?.toData() {
                    return result
                } else {
                    throw DBError.queryError
                }
            }
            .mapError { DBError(error: $0) }
            .eraseToAnyPublisher()
    }
    
    func save<T: DAORepresentable>(object: T) async -> Result<Void, DBError> where T == T.DAOType.DataType {
        do {
            try await withCheckedThrowingContinuation({ continuation in
                operationQueue.addOperation {
                    do {
                        try self.realm.write {
                            self.realm.add(object.toDAO(), update: .modified)
                            continuation.resume()
                        }
                    } catch(let error) {
                        continuation.resume(throwing: DBError(error: error))
                    }
                }
            })
            return .success(())
        } catch(let error) {
            return .failure(DBError(error: error))
        }
    }
    
    
    func deleteAll<T: DAORepresentable>(_ model: T.Type) async -> Result<Void, DBError> where T == T.DAOType.DataType {
        do {
            try await withCheckedThrowingContinuation({ continuation in
                operationQueue.addOperation {
                    do {
                        try self.realm.write {
                            let objects = self.realm.objects(model.DAOType)
                            self.realm.delete(objects)
                            continuation.resume()
                        }
                    } catch(let error) {
                        continuation.resume(throwing: DBError(error: error))
                    }
                }
            })
            return .success(())
        } catch(let error) {
            return .failure(DBError(error: error))
        }
    }
    
}
