//
//  TopAPIServiceProtocol.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation
import Combine

public protocol TopAPIServiceProtocol {
    func fetchTopAnime(type: AnimeType, filter: AnimeFilter, rating: AnimeRating, sfw: Bool, page: Int, limit: Int) -> AnyPublisher<AnimeResponse, Error>
}
