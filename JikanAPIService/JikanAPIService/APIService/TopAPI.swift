//
//  TopAPI.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation
import Alamofire
import Moya
import MoyaHelper

public enum TopAnimeType: String, CaseIterable, Identifiable, CustomStringConvertible {
    case tv
    case tvSpecial = "tv_special"
    case movie
    case ova
    case special
    case ona
    case pv
    case music
    case cm
    
    public var id: String { rawValue }
    
    var apiValue: String {
        return self.rawValue
    }
    
    public var description: String {
        switch self {
        case .tv:
            return "TV"
        case .tvSpecial:
            return "TV Special"
        case .movie:
            return "Movie"
        case .ova:
            return "OVA"
        case .special:
            return "Special"
        case .ona:
            return "ONA"
        case .pv:
            return "PV"
        case .music:
            return "Music"
        case .cm:
            return "CM"
        }
    }
}

public enum TopAnimeFilter: String, CaseIterable, Identifiable, CustomStringConvertible {
    case byPopularity = "bypopularity"
    case upcoming
    case airing
    case favorite
    
    public var id: String { rawValue }
    
    var apiValue: String {
        return self.rawValue
    }
    
    public var description: String {
        switch self {
        case .byPopularity:
            return "By Popularity"
        case .upcoming:
            return "Upcoming"
        case .airing:
            return "Airing"
        case .favorite:
            return "Favorite"
        }
    }
}

public enum TopAnimeRating: String, CaseIterable, Identifiable, CustomStringConvertible {
    case g
    case pg
    case pg13
    case r17
    case r
    case rx
    
    public var id: String { rawValue }
    
    var apiValue: String {
        return self.rawValue
    }
    
    public var description: String {
        switch self {
        case .g:
            return "G"
        case .pg:
            return "PG"
        case .pg13:
            return "PG-13"
        case .r17:
            return "R17+"
        case .r:
            return "R+"
        case .rx:
            return "Rx"
        }
    }
}

public enum TopMangaType: String, CaseIterable, Identifiable, CustomStringConvertible {
    case manga
    case novel
    case lightnovel
    case oneshot
    case doujin
    case manhwa
    case manhua
    
    public var id: String { rawValue }
    
    var apiValue: String {
        return self.rawValue
    }
    
    public var description: String {
        switch self {
        case .manga:
            return "Manga"
        case .novel:
            return "Novel"
        case .lightnovel:
            return "Light Novel"
        case .oneshot:
            return "One-shot"
        case .doujin:
            return "Doujin"
        case .manhwa:
            return "Manhwa"
        case .manhua:
            return "Manhua"
        }
    }
}


public enum TopMangaFilter: String, CaseIterable, Identifiable, CustomStringConvertible {
    case publishing
    case upcoming
    case byPopularity = "bypopularity"
    case favorite
    
    public var id: String { rawValue }
    
    var apiValue: String {
        return self.rawValue
    }
    
    public var description: String {
        switch self {
        case .publishing:
            return "Publishing"
        case .upcoming:
            return "Upcoming"
        case .byPopularity:
            return "By Popularity"
        case .favorite:
            return "Favorite"
        }
    }
}

public enum TopAPI {
    case getTopAnime(type: TopAnimeType, filter: TopAnimeFilter, rating: TopAnimeRating, sfw: Bool, page: Int, limit: Int)
    case getTopManga(type: TopMangaType, filter: TopMangaFilter, page: Int, limit: Int)
}

extension TopAPI: JikanTargetType {
    public var path: String {
        switch self {
        case .getTopAnime:
            return "/top/anime"
            
        case .getTopManga:
            return "/top/manga"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getTopAnime, .getTopManga:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getTopAnime(let type, let filter, let rating, let sfw, let page, let limit):
            let parameters: [String: Any] = [
                "type": type.apiValue,
                "filter": filter.apiValue,
                "rating": rating.apiValue,
                "sfw": sfw ? "true" : "false",
                "page": page,
                "limit": limit
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .getTopManga(let type, let filter, let page, let limit):
            let parameters: [String: Any] = [
                "type": type.apiValue,
                "filter": filter.apiValue,
                "page": page,
                "limit": limit
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getTopAnime, .getTopManga:
            return nil
        }
    }
    
}
