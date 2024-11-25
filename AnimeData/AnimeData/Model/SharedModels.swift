//
//  SharedModels.swift
//  AnimeData
//
//  Created by DAO on 2024/11/22.
//

import Foundation
import SwiftData

// MARK: - Images
@Model
public final class Images: Decodable {
    public var jpg: ImageUrls
    public var webp: ImageUrls
    
    enum CodingKeys: String, CodingKey {
        case jpg, webp
    }
    
    public init(jpg: ImageUrls, webp: ImageUrls) {
        self.jpg = jpg
        self.webp = webp
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.jpg = try container.decode(ImageUrls.self, forKey: .jpg)
        self.webp = try container.decode(ImageUrls.self, forKey: .webp)
    }
}

// MARK: - ImageUrls
@Model
public final class ImageUrls: Decodable {
    public var imageUrl: String
    public var smallImageUrl: String
    public var largeImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl, smallImageUrl, largeImageUrl
    }
    
    public init(imageUrl: String, smallImageUrl: String, largeImageUrl: String) {
        self.imageUrl = imageUrl
        self.smallImageUrl = smallImageUrl
        self.largeImageUrl = largeImageUrl
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.smallImageUrl = try container.decode(String.self, forKey: .smallImageUrl)
        self.largeImageUrl = try container.decode(String.self, forKey: .largeImageUrl)
    }
}

// MARK: - Prop
@Model
public final class Prop: Decodable {
    public var from: DateProp
    public var to: DateProp
    
    enum CodingKeys: String, CodingKey {
        case from, to
    }
    
    public init(from: DateProp, to: DateProp) {
        self.from = from
        self.to = to
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.from = try container.decode(DateProp.self, forKey: .from)
        self.to = try container.decode(DateProp.self, forKey: .to)
    }
}

// MARK: - DateProp
@Model
public final class DateProp: Decodable {
    public var day: Int?
    public var month: Int?
    public var year: Int?
    
    enum CodingKeys: String, CodingKey {
        case day, month, year
    }
    
    public init(day: Int? = nil, month: Int? = nil, year: Int? = nil) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try container.decodeIfPresent(Int.self, forKey: .day)
        self.month = try container.decodeIfPresent(Int.self, forKey: .month)
        self.year = try container.decodeIfPresent(Int.self, forKey: .year)
    }
}

// MARK: - Title
@Model
public final class Title: Decodable {
    public var type: String
    public var title: String
    
    enum CodingKeys: String, CodingKey {
        case type, title
    }
    
    public init(type: String, title: String) {
        self.type = type
        self.title = title
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.title = try container.decode(String.self, forKey: .title)
    }
}

// MARK: - Pagination
@Model
public final class Pagination: Decodable {
    public var lastVisiblePage: Int
    public var hasNextPage: Bool
    public var items: PaginationItems
    public var currentPage: Int
    
    enum CodingKeys: String, CodingKey {
        case lastVisiblePage
        case hasNextPage
        case items
        case currentPage
    }
    
    public init(lastVisiblePage: Int, hasNextPage: Bool, items: PaginationItems, currentPage: Int) {
        self.lastVisiblePage = lastVisiblePage
        self.hasNextPage = hasNextPage
        self.items = items
        self.currentPage = currentPage
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lastVisiblePage = try container.decode(Int.self, forKey: .lastVisiblePage)
        self.hasNextPage = try container.decode(Bool.self, forKey: .hasNextPage)
        self.items = try container.decode(PaginationItems.self, forKey: .items)
        self.currentPage = try container.decode(Int.self, forKey: .currentPage)
    }
}

// MARK: - PaginationItems
@Model
public final class PaginationItems: Decodable {
    public var count: Int
    public var total: Int
    public var perPage: Int
    
    enum CodingKeys: String, CodingKey {
        case count, total
        case perPage
    }
    
    public init(count: Int, total: Int, perPage: Int) {
        self.count = count
        self.total = total
        self.perPage = perPage
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.total = try container.decode(Int.self, forKey: .total)
        self.perPage = try container.decode(Int.self, forKey: .perPage)
    }
}

