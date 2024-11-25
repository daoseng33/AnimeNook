//
//  TopManga.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/18.
//

import Foundation
import SwiftData

@Model
public final class TopManga: Identifiable, Decodable {
    public var malId: Int
    public var url: String
    public var images: Images
    public var approved: Bool
    public var titles: [Title]
    public var title: String
    public var titleEnglish: String?
    public var titleJapanese: String?
    public var type: String
    public var chapters: Int?
    public var volumes: Int?
    public var status: String
    public var publishing: Bool
    public var published: PublishedDate
    public var score: Double
    public var scoredBy: Int
    public var rank: Int
    public var popularity: Int
    public var members: Int
    public var favorites: Int
    public var synopsis: String
    public var background: String?
    public var authors: [Author]
    public var serializations: [Author]
    public var genres: [Author]
    public var explicitGenres: [Author]
    public var themes: [Author]
    public var demographics: [Author]
    
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
        self.published = try container.decode(PublishedDate.self, forKey: .published)
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
        published: PublishedDate,
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
}


// MARK: - Author
@Model
public final class Author: Decodable {
    public var malId: Int
    public var type: String
    public var name: String
    public var url: String
    
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
}

// MARK: - Published
@Model
public final class PublishedDate: Decodable {
    public var string: String?
    public var from: String?
    public var to: String?
    public var prop: Prop
    
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
}


