//
//  TopAPIServiceProtocol.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation
import Combine

public protocol TopAPIServiceProtocol {
    func fetchTopAnime(type: TopAnimeType, filter: TopAnimeFilter, rating: TopAnimeRating, sfw: Bool, page: Int, limit: Int) -> AnyPublisher<TopAnimeResponse, Error>
    func fetchTopManga(type: TopMangaType, filter: TopMangaFilter, page: Int, limit: Int) -> AnyPublisher<TopMangaResponse, Error>
}
