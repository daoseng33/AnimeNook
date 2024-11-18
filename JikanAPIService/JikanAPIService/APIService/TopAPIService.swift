//
//  TopAPIService.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation
import Combine
import Moya
import CombineMoya
import MoyaHelper

public struct TopAPIService: TopAPIServiceProtocol {
    private let provider = MoyaProvider<TopAPI>.default
    
    public init() { }
    
    public func fetchTopAnime(type: TopAnimeType, filter: TopAnimeFilter, rating: TopAnimeRating, sfw: Bool, page: Int, limit: Int) -> AnyPublisher<TopAnimeResponse, any Error> {
        return provider
            .requestPublisher(.getTopAnime(type: type,
                                           filter: filter,
                                           rating: rating,
                                           sfw: sfw, page: page,
                                           limit: limit))
            .tryMap { response in
                let decoder = JSONDecoder.default
                return try decoder.decode(TopAnimeResponse.self, from: response.data)
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchTopManga(type: TopMangaType, filter: TopMangaFilter, page: Int, limit: Int) -> AnyPublisher<TopMangaResponse, Error> {
        return provider
            .requestPublisher(.getTopManga(type: type,
                                           filter: filter,
                                           page: page,
                                           limit: limit))
            .tryMap { response in
                let decoder = JSONDecoder.default
                return try decoder.decode(TopMangaResponse.self, from: response.data)
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
