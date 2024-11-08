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

public enum AnimeType: String, CaseIterable {
    case movie
    case ova
    case special
    case ona
    case pv
    case tv
    case tvSpecial = "tv_special"
    case music
    case cm
}

public enum AnimeFilter: String, CaseIterable {
    case bypopularity
    case upcoming
    case airing
    case favorite
}

public enum AnimeRating: String, CaseIterable {
    case g
    case pg
    case pg13
    case r17
    case r
    case rx
}

public enum TopAPI {
    case getTopAnime(type: AnimeType, filter: AnimeFilter, rating: AnimeRating, sfw: Bool, page: Int, limit: Int)
}

extension TopAPI: JikanTargetType {
    public var path: String {
        switch self {
        case .getTopAnime:
            return "/top/anime"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getTopAnime:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getTopAnime(let type, let filter, let rating, let sfw, let page, let limit):
            let parameters: [String: Any] = [
                "type": type.rawValue,
                "filter": filter.rawValue,
                "rating": rating.rawValue,
                "sfw": sfw ? "true" : "false",
                "page": page,
                "limit": limit
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getTopAnime:
            return nil
        }
    }
    
}