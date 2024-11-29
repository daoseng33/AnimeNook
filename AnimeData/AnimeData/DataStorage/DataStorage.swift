//
//  DataStorage.swift
//  Meme
//
//  Created by DAO on 2024/10/2.
//

import Foundation
import SwiftData

public enum DataStorageError: Error, LocalizedError {
    case failedToSave(underlying: Error? = nil)
    case failedToDelete(underlying: Error? = nil)
    case failedToFetch(underlying: Error? = nil)
    case itemNotFound
    case invalidModelContext
    case transactionFailed(underlying: Error? = nil)
    
    public var errorDescription: String? {
        switch self {
        case .failedToSave(let error):
            return "Failed to save: \(error?.localizedDescription ?? "Unknown error")"
        case .failedToDelete(let error):
            return "Failed to delete: \(error?.localizedDescription ?? "Unknown error")"
        case .failedToFetch(let error):
            return "Failed to fetch: \(error?.localizedDescription ?? "Unknown error")"
        case .itemNotFound:
            return "Item not found"
        case .invalidModelContext:
            return "Invalid model context"
        case .transactionFailed(let error):
            return "Transaction failed: \(error?.localizedDescription ?? "Unknown error")"
        }
    }
}

/// A generic data storage class that provides CRUD operations for SwiftData models
/// - Parameter T: The type of the model that conforms to PersistentModel
@MainActor
final public class DataStorage<T: PersistentModel>: DataStorageProtocol {
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Transaction Support
    
    /// Performs multiple operations in a single transaction
    /// - Parameter block: The closure containing the operations to perform
    /// - Throws: DataStorageError if the transaction fails
    public func performTransaction(_ block: () async throws -> Void) async throws {
        do {
            try await block()
            try saveContext()
        } catch {
            print("Transaction failed: \(error)")
            throw DataStorageError.transactionFailed(underlying: error)
        }
    }
    
    // MARK: - Create
    
    /// Creates a new item in the store
    /// - Parameter item: The item to create
    /// - Throws: DataStorageError if the save fails
    public func create(_ item: T) async throws {
        try Task.checkCancellation()
        modelContext.insert(item)
        try saveContext()
    }
    
    // MARK: - Read
    
    /// Fetches items matching the given predicate
    /// - Parameters:
    ///   - predicate: Optional predicate to filter results
    ///   - sortBy: Optional sort descriptors
    ///   - limit: Optional limit to the number of results
    /// - Returns: Array of matching items
    public func fetch(
        predicate: Predicate<T>? = nil,
        sortBy: [SortDescriptor<T>] = [],
        limit: Int? = nil
    ) async throws -> [T] {
        try Task.checkCancellation()
        var descriptor = FetchDescriptor<T>(predicate: predicate)
        descriptor.sortBy = sortBy
        if let limit = limit {
            descriptor.fetchLimit = limit
        }
        return try modelContext.fetch(descriptor)
    }
    
    public func fetchOne(predicate: Predicate<T>) async throws -> T? {
        try Task.checkCancellation()
        var descriptor = FetchDescriptor<T>(predicate: predicate)
        descriptor.fetchLimit = 1
        let results = try modelContext.fetch(descriptor)
        return results.first
    }
    
    // MARK: - Update
    
    public func update(_ item: T) async throws {
        try Task.checkCancellation()
        try saveContext()
    }
    
    // MARK: - Delete
    
    public func delete(_ item: T) async throws {
        try Task.checkCancellation()
        modelContext.delete(item)
        try saveContext()
    }
    
    // MARK: - Batch Operations
    
    public func batchCreate(_ items: [T]) async throws {
        try Task.checkCancellation()
        items.forEach { modelContext.insert($0) }
        try saveContext()
    }
    
    public func batchDelete(_ items: [T]) async throws {
        try Task.checkCancellation()
        items.forEach { modelContext.delete($0) }
        try saveContext()
    }
    
    // MARK: - Helper Methods
    
    private func saveContext() throws {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
            throw DataStorageError.failedToSave(underlying: error)
        }
    }
}
