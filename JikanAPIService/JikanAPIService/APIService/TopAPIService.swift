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
    
    public func fetchTopAnime(type: AnimeType, filter: AnimeFilter, rating: AnimeRating, sfw: Bool, page: Int, limit: Int) -> AnyPublisher<AnimeResponse, any Error> {
        return provider.requestPublisher(.getTopAnime(type: type,
                                                      filter: filter,
                                                      rating: rating,
                                                      sfw: sfw, page: page,
                                                      limit: limit))
            .tryMap { response in
                let decoder = JSONDecoder.default
                return try decoder.decode(AnimeResponse.self, from: response.data)
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
