//
//  Pagination.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation

public struct Pagination: Decodable {
    public let lastVisiblePage: Int
    public let hasNextPage: Bool
    public let currentPage: Int
    public let items: Items
}

public struct Items: Decodable {
    public let count: Int
    public let total: Int
    public let perPage: Int
}
