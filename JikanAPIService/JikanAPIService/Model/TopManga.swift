//
//  TopManga.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/18.
//

import Foundation

// MARK: - TopManga
public struct TopManga: Decodable, Identifiable {
    public let malId: Int
    public let url: String
    public let images: Images
    public let approved: Bool
    public let titles: [Title]
    public let title: String
    public let titleEnglish: String?
    public let titleJapanese: String?
    public let type: String
    public let chapters: Int?
    public let volumes: Int?
    public let status: String
    public let publishing: Bool
    public let published: PublishedDate
    public let score: Double
    public let scoredBy: Int
    public let rank: Int
    public let popularity: Int
    public let members: Int
    public let favorites: Int
    public let synopsis: String?
    public let background: String?
    public let authors: [Author]
    public let serializations: [Author]
    public let genres: [Author]
    public let explicitGenres: [Author]
    public let themes: [Author]
    public let demographics: [Author]
    
    public var id: Int { malId }
    
    public enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case url, images, approved, titles, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case type, chapters, volumes, status, publishing, published
        case score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites
        case synopsis, background
        case authors, serializations, genres
        case explicitGenres = "explicit_genres"
        case themes, demographics
    }
}

// MARK: - Author
public struct Author: Decodable {
    public let malId: Int
    public let type: String
    public let name: String
    public let url: String

    public enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case type, name, url
    }
}

// MARK: - Images
public struct Images: Decodable {
    public let jpg: ImageUrls
    public let webp: ImageUrls
}

// MARK: - ImageUrls
public struct ImageUrls: Decodable {
    public let imageUrl: String
    public let smallImageUrl: String
    public let largeImageUrl: String

    public enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case smallImageUrl = "small_image_url"
        case largeImageUrl = "large_image_url"
    }
}

// MARK: - Published
public struct PublishedDate: Decodable {
    public let from: String?
    public let to: String?
    public let prop: Prop
}

// MARK: - Prop
public struct Prop: Decodable {
    public let from: DateProp
    public let to: DateProp
    public let string: String
}

// MARK: - DateProp
public struct DateProp: Codable {
    public let day: Int?
    public let month: Int?
    public let year: Int?
}

// MARK: - Title
public struct Title: Codable {
    public let type: String
    public let title: String
}
