//
//  DataStorage.swift
//  Meme
//
//  Created by DAO on 2024/10/2.
//

import Foundation
import SwiftData

enum DataStorageError: Error {
    case failedToSave
    case failedToDelete
    case failedToFetch
    case itemNotFound
    case invalidModelContext
}

@MainActor
final class DataStorage<T: PersistentModel>: DataStorageProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Create
    func create(_ item: T) async throws {
        modelContext.insert(item)
        try saveContext()
    }
    
    // MARK: - Read
    func fetch(predicate: Predicate<T>? = nil) async throws -> [T] {
        let descriptor = FetchDescriptor<T>(predicate: predicate)
        return try modelContext.fetch(descriptor)
    }
    
    func fetchOne(predicate: Predicate<T>) async throws -> T? {
        let descriptor = FetchDescriptor<T>(predicate: predicate)
        let results = try modelContext.fetch(descriptor)
        return results.first
    }
    
    // MARK: - Update
    func update(_ item: T) async throws {
        try saveContext()
    }
    
    // MARK: - Delete
    func delete(_ item: T) async throws {
        modelContext.delete(item)
        try saveContext()
    }
    
    // MARK: - Batch Operations
    func batchCreate(_ items: [T]) async throws {
        items.forEach { modelContext.insert($0) }
        try saveContext()
    }
    
    func batchDelete(_ items: [T]) async throws {
        items.forEach { modelContext.delete($0) }
        try saveContext()
    }
    
    // MARK: - Helper Methods
    private func saveContext() throws {
        do {
            try modelContext.save()
        } catch {
            throw DataStorageError.failedToSave
        }
    }
}
