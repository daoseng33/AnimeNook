//
//  TopManga.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/18.
//

import Foundation
import SwiftData

@Model
public final class TopManga: Identifiable, Codable, Equatable {
    @Attribute(.unique) public var malId: Int
    public var url: String
    public var images: Images
    public var approved: Bool
    @Relationship(deleteRule: .cascade) public var titles: [Title]
    public var title: String
    public var titleEnglish: String?
    public var titleJapanese: String?
    public var type: String
    public var chapters: Int?
    public var volumes: Int?
    public var status: String
    public var publishing: Bool
    @Relationship(deleteRule: .cascade) public var published: PublishedDate?
    public var score: Double
    public var scoredBy: Int
    public var rank: Int
    public var popularity: Int
    public var members: Int
    public var favorites: Int
    public var synopsis: String
    public var background: String?
    @Relationship(deleteRule: .cascade) public var authors: [Author]
    @Relationship(deleteRule: .cascade) public var serializations: [Author]
    @Relationship(deleteRule: .cascade) public var genres: [Author]
    @Relationship(deleteRule: .cascade) public var explicitGenres: [Author]
    @Relationship(deleteRule: .cascade) public var themes: [Author]
    @Relationship(deleteRule: .cascade) public var demographics: [Author]
    
    public var id: Int { malId }
    
    enum CodingKeys: String, CodingKey {
        case malId
        case url
        case images
        case approved
        case titles
        case title
        case titleEnglish
        case titleJapanese
        case type
        case chapters
        case volumes
        case status
        case publishing
        case published
        case score
        case scoredBy
        case rank
        case popularity
        case members
        case favorites
        case synopsis
        case background
        case authors
        case serializations
        case genres
        case explicitGenres
        case themes
        case demographics
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.malId = try container.decode(Int.self, forKey: .malId)
        self.url = try container.decode(String.self, forKey: .url)
        self.images = try container.decode(Images.self, forKey: .images)
        self.approved = try container.decode(Bool.self, forKey: .approved)
        self.titles = try container.decode([Title].self, forKey: .titles)
        self.title = try container.decode(String.self, forKey: .title)
        self.titleEnglish = try container.decodeIfPresent(String.self, forKey: .titleEnglish)
        self.titleJapanese = try container.decodeIfPresent(String.self, forKey: .titleJapanese)
        self.type = try container.decode(String.self, forKey: .type)
        self.chapters = try container.decodeIfPresent(Int.self, forKey: .chapters)
        self.volumes = try container.decodeIfPresent(Int.self, forKey: .volumes)
        self.status = try container.decode(String.self, forKey: .status)
        self.publishing = try container.decode(Bool.self, forKey: .publishing)
        self.published = try container.decodeIfPresent(PublishedDate.self, forKey: .published)
        self.score = try container.decode(Double.self, forKey: .score)
        self.scoredBy = try container.decode(Int.self, forKey: .scoredBy)
        self.rank = try container.decode(Int.self, forKey: .rank)
        self.popularity = try container.decode(Int.self, forKey: .popularity)
        self.members = try container.decode(Int.self, forKey: .members)
        self.favorites = try container.decode(Int.self, forKey: .favorites)
        self.synopsis = try container.decode(String.self, forKey: .synopsis)
        self.background = try container.decodeIfPresent(String.self, forKey: .background)
        self.authors = try container.decode([Author].self, forKey: .authors)
        self.serializations = try container.decode([Author].self, forKey: .serializations)
        self.genres = try container.decode([Author].self, forKey: .genres)
        self.explicitGenres = try container.decode([Author].self, forKey: .explicitGenres)
        self.themes = try container.decode([Author].self, forKey: .themes)
        self.demographics = try container.decode([Author].self, forKey: .demographics)
    }
    
    public init(
        malId: Int,
        url: String,
        images: Images,
        approved: Bool,
        titles: [Title],
        title: String,
        titleEnglish: String? = nil,
        titleJapanese: String? = nil,
        type: String,
        chapters: Int? = nil,
        volumes: Int? = nil,
        status: String,
        publishing: Bool,
        published: PublishedDate? = nil,
        score: Double,
        scoredBy: Int,
        rank: Int,
        popularity: Int,
        members: Int,
        favorites: Int,
        synopsis: String,
        background: String? = nil,
        authors: [Author],
        serializations: [Author],
        genres: [Author],
        explicitGenres: [Author],
        themes: [Author],
        demographics: [Author]
    ) {
        self.malId = malId
        self.url = url
        self.images = images
        self.approved = approved
        self.titles = titles
        self.title = title
        self.titleEnglish = titleEnglish
        self.titleJapanese = titleJapanese
        self.type = type
        self.chapters = chapters
        self.volumes = volumes
        self.status = status
        self.publishing = publishing
        self.published = published
        self.score = score
        self.scoredBy = scoredBy
        self.rank = rank
        self.popularity = popularity
        self.members = members
        self.favorites = favorites
        self.synopsis = synopsis
        self.background = background
        self.authors = authors
        self.serializations = serializations
        self.genres = genres
        self.explicitGenres = explicitGenres
        self.themes = themes
        self.demographics = demographics
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(malId, forKey: .malId)
        try container.encode(url, forKey: .url)
        try container.encode(images, forKey: .images)
        try container.encode(approved, forKey: .approved)
        try container.encode(titles, forKey: .titles)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(titleEnglish, forKey: .titleEnglish)
        try container.encodeIfPresent(titleJapanese, forKey: .titleJapanese)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(chapters, forKey: .chapters)
        try container.encodeIfPresent(volumes, forKey: .volumes)
        try container.encode(status, forKey: .status)
        try container.encode(publishing, forKey: .publishing)
        try container.encodeIfPresent(published, forKey: .published)
        try container.encode(score, forKey: .score)
        try container.encode(scoredBy, forKey: .scoredBy)
        try container.encode(rank, forKey: .rank)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(members, forKey: .members)
        try container.encode(favorites, forKey: .favorites)
        try container.encode(synopsis, forKey: .synopsis)
        try container.encodeIfPresent(background, forKey: .background)
        try container.encode(authors, forKey: .authors)
        try container.encode(serializations, forKey: .serializations)
        try container.encode(genres, forKey: .genres)
        try container.encode(explicitGenres, forKey: .explicitGenres)
        try container.encode(themes, forKey: .themes)
        try container.encode(demographics, forKey: .demographics)
    }
    
    public static func == (lhs: TopManga, rhs: TopManga) -> Bool {
        lhs.malId == rhs.malId
    }
}

// MARK: - Author
@Model
public final class Author: Codable {
    public var malId: Int
    public var type: String
    public var name: String
    public var url: String
    
    @Relationship(inverse: \TopManga.authors)
    public var mangaAuthors: TopManga?
    
    @Relationship(inverse: \TopManga.serializations)
    public var mangaSerializations: TopManga?
    
    @Relationship(inverse: \TopManga.genres)
    public var mangaGenres: TopManga?
    
    @Relationship(inverse: \TopManga.explicitGenres)
    public var mangaExplicitGenres: TopManga?
    
    @Relationship(inverse: \TopManga.themes)
    public var mangaThemes: TopManga?
    
    @Relationship(inverse: \TopManga.demographics)
    public var mangaDemographics: TopManga?
    
    enum CodingKeys: String, CodingKey {
        case malId
        case type
        case name
        case url
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.malId = try container.decode(Int.self, forKey: .malId)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
    public init(malId: Int, type: String, name: String, url: String) {
        self.malId = malId
        self.type = type
        self.name = name
        self.url = url
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(malId, forKey: .malId)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
}

// MARK: - Published
@Model
public final class PublishedDate: Codable {
    public var string: String?
    public var from: String?
    public var to: String?
    public var prop: Prop
    
    @Relationship(inverse: \TopManga.published)
    public var manga: TopManga?
    
    enum CodingKeys: String, CodingKey {
        case string
        case from
        case to
        case prop
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.string = try container.decodeIfPresent(String.self, forKey: .string)
        self.from = try container.decodeIfPresent(String.self, forKey: .from)
        self.to = try container.decodeIfPresent(String.self, forKey: .to)
        self.prop = try container.decode(Prop.self, forKey: .prop)
    }
    
    public init(string: String? = nil, from: String? = nil, to: String? = nil, prop: Prop) {
        self.string = string
        self.from = from
        self.to = to
        self.prop = prop
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(string, forKey: .string)
        try container.encodeIfPresent(from, forKey: .from)
        try container.encodeIfPresent(to, forKey: .to)
        try container.encode(prop, forKey: .prop)
    }
}


