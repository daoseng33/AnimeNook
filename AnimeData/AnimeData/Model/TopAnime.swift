//
//  TopAnime.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation
import SwiftData

// MARK: - TopAnime
@Model
public final class TopAnime: Identifiable, Decodable {
    public var malId: Int
    public var url: String
    public var images: Images
    public var trailer: Trailer?
    public var approved: Bool
    public var titles: [Title]
    public var title: String
    public var titleEnglish: String?
    public var titleJapanese: String?
    public var titleSynonyms: [String]
    public var type: String
    public var source: String
    public var episodes: Int?
    public var status: String
    public var airing: Bool
    public var aired: Aired?
    public var duration: String
    public var rating: String
    public var score: Double
    public var scoredBy: Int
    public var rank: Int
    public var popularity: Int
    public var members: Int
    public var favorites: Int
    public var synopsis: String
    public var background: String?
    public var season: String?
    public var year: Int?
    public var broadcast: Broadcast?
    public var producers: [Producer]
    public var licensors: [Producer]
    public var studios: [Producer]
    public var genres: [Genre]
    public var explicitGenres: [Genre]
    public var themes: [Genre]
    public var demographics: [Genre]
    
    public var id: Int { malId }
    
    enum CodingKeys: String, CodingKey {
        case malId
        case url
        case images
        case trailer
        case approved
        case titles
        case title
        case titleEnglish
        case titleJapanese
        case titleSynonyms
        case type
        case source
        case episodes
        case status
        case airing
        case aired
        case duration
        case rating
        case score
        case scoredBy
        case rank
        case popularity
        case members
        case favorites
        case synopsis
        case background
        case season
        case year
        case broadcast
        case producers
        case licensors
        case studios
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
        self.trailer = try container.decodeIfPresent(Trailer.self, forKey: .trailer)
        self.approved = try container.decode(Bool.self, forKey: .approved)
        self.titles = try container.decode([Title].self, forKey: .titles)
        self.title = try container.decode(String.self, forKey: .title)
        self.titleEnglish = try container.decodeIfPresent(String.self, forKey: .titleEnglish)
        self.titleJapanese = try container.decodeIfPresent(String.self, forKey: .titleJapanese)
        self.titleSynonyms = try container.decode([String].self, forKey: .titleSynonyms)
        self.type = try container.decode(String.self, forKey: .type)
        self.source = try container.decode(String.self, forKey: .source)
        self.episodes = try container.decodeIfPresent(Int.self, forKey: .episodes)
        self.status = try container.decode(String.self, forKey: .status)
        self.airing = try container.decode(Bool.self, forKey: .airing)
        self.aired = try container.decodeIfPresent(Aired.self, forKey: .aired)
        self.duration = try container.decode(String.self, forKey: .duration)
        self.rating = try container.decode(String.self, forKey: .rating)
        self.score = try container.decode(Double.self, forKey: .score)
        self.scoredBy = try container.decode(Int.self, forKey: .scoredBy)
        self.rank = try container.decode(Int.self, forKey: .rank)
        self.popularity = try container.decode(Int.self, forKey: .popularity)
        self.members = try container.decode(Int.self, forKey: .members)
        self.favorites = try container.decode(Int.self, forKey: .favorites)
        self.synopsis = try container.decode(String.self, forKey: .synopsis)
        self.background = try container.decodeIfPresent(String.self, forKey: .background)
        self.season = try container.decodeIfPresent(String.self, forKey: .season)
        self.year = try container.decodeIfPresent(Int.self, forKey: .year)
        self.broadcast = try container.decodeIfPresent(Broadcast.self, forKey: .broadcast)
        self.producers = try container.decode([Producer].self, forKey: .producers)
        self.licensors = try container.decode([Producer].self, forKey: .licensors)
        self.studios = try container.decode([Producer].self, forKey: .studios)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.explicitGenres = try container.decode([Genre].self, forKey: .explicitGenres)
        self.themes = try container.decode([Genre].self, forKey: .themes)
        self.demographics = try container.decode([Genre].self, forKey: .demographics)
    }
    
    public init(
        malId: Int,
        url: String,
        images: Images,
        trailer: Trailer? = nil,
        approved: Bool,
        titles: [Title],
        title: String,
        titleEnglish: String? = nil,
        titleJapanese: String? = nil,
        titleSynonyms: [String],
        type: String,
        source: String,
        episodes: Int? = nil,
        status: String,
        airing: Bool,
        aired: Aired? = nil,
        duration: String,
        rating: String,
        score: Double,
        scoredBy: Int,
        rank: Int,
        popularity: Int,
        members: Int,
        favorites: Int,
        synopsis: String,
        background: String? = nil,
        season: String? = nil,
        year: Int? = nil,
        broadcast: Broadcast? = nil,
        producers: [Producer],
        licensors: [Producer],
        studios: [Producer],
        genres: [Genre],
        explicitGenres: [Genre],
        themes: [Genre],
        demographics: [Genre]
    ) {
        self.malId = malId
        self.url = url
        self.images = images
        self.trailer = trailer
        self.approved = approved
        self.titles = titles
        self.title = title
        self.titleEnglish = titleEnglish
        self.titleJapanese = titleJapanese
        self.titleSynonyms = titleSynonyms
        self.type = type
        self.source = source
        self.episodes = episodes
        self.status = status
        self.airing = airing
        self.aired = aired
        self.duration = duration
        self.rating = rating
        self.score = score
        self.scoredBy = scoredBy
        self.rank = rank
        self.popularity = popularity
        self.members = members
        self.favorites = favorites
        self.synopsis = synopsis
        self.background = background
        self.season = season
        self.year = year
        self.broadcast = broadcast
        self.producers = producers
        self.licensors = licensors
        self.studios = studios
        self.genres = genres
        self.explicitGenres = explicitGenres
        self.themes = themes
        self.demographics = demographics
    }
}


// MARK: - Trailer
@Model
public final class Trailer: Decodable {
    public var youtubeId: String?
    public var url: String?
    public var embedUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case youtubeId
        case url
        case embedUrl
    }
    
    public init(youtubeId: String? = nil, url: String? = nil, embedUrl: String? = nil) {
        self.youtubeId = youtubeId
        self.url = url
        self.embedUrl = embedUrl
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.youtubeId = try container.decodeIfPresent(String.self, forKey: .youtubeId)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.embedUrl = try container.decodeIfPresent(String.self, forKey: .embedUrl)
    }
}

// MARK: - Aired
@Model
public final class Aired: Decodable {
    public var from: String?
    public var to: String?
    public var prop: AiredProp?
    
    enum CodingKeys: String, CodingKey {
        case from, to, prop
    }
    
    public init(from: String? = nil, to: String? = nil, prop: AiredProp? = nil) {
        self.from = from
        self.to = to
        self.prop = prop
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.from = try container.decodeIfPresent(String.self, forKey: .from)
        self.to = try container.decodeIfPresent(String.self, forKey: .to)
        self.prop = try container.decodeIfPresent(AiredProp.self, forKey: .prop)
    }
}

// MARK: - AiredProp
@Model
public final class AiredProp: Decodable {
    public var from: DateProp?
    public var to: DateProp?
    public var string: String?
    
    enum CodingKeys: String, CodingKey {
        case from, to, string
    }
    
    public init(from: DateProp? = nil, to: DateProp? = nil, string: String? = nil) {
        self.from = from
        self.to = to
        self.string = string
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.from = try container.decodeIfPresent(DateProp.self, forKey: .from)
        self.to = try container.decodeIfPresent(DateProp.self, forKey: .to)
        self.string = try container.decodeIfPresent(String.self, forKey: .string)
    }
}

// MARK: - Broadcast
@Model
public final class Broadcast: Decodable {
    public var day: String?
    public var time: String?
    public var timezone: String?
    public var string: String?
    
    enum CodingKeys: String, CodingKey {
        case day, time, timezone, string
    }
    
    public init(day: String? = nil, time: String? = nil, timezone: String? = nil, string: String? = nil) {
        self.day = day
        self.time = time
        self.timezone = timezone
        self.string = string
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try container.decodeIfPresent(String.self, forKey: .day)
        self.time = try container.decodeIfPresent(String.self, forKey: .time)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.string = try container.decodeIfPresent(String.self, forKey: .string)
    }
}

// MARK: - Producer/Studio/Licensor
@Model
public final class Producer: Decodable {
    public var malId: Int
    public var type: String
    public var name: String
    public var url: String
    
    enum CodingKeys: String, CodingKey {
        case malId, type, name, url
    }
    
    public init(malId: Int, type: String, name: String, url: String) {
        self.malId = malId
        self.type = type
        self.name = name
        self.url = url
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.malId = try container.decode(Int.self, forKey: .malId)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

// MARK: - Genre/Theme/Demographic
@Model
public final class Genre: Decodable {
    public var malId: Int
    public var type: String
    public var name: String
    public var url: String
    
    public init(malId: Int, type: String, name: String, url: String) {
        self.malId = malId
        self.type = type
        self.name = name
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case malId, type, name, url
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.malId = try container.decode(Int.self, forKey: .malId)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
