//
//  DataStorageProtocol.swift
//  AnimeData
//
//  Created by DAO on 2024/11/25.
//

import Foundation

protocol DataStorageProtocol {
    associatedtype T
    
    func create(_ item: T) async throws
    func fetch(predicate: Predicate<T>?) async throws -> [T]
    func update(_ item: T) async throws
    func delete(_ item: T) async throws
}
