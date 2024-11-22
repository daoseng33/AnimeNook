//
//  TopAnimeResponse.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation

public struct TopAnimeResponse: Decodable {
    public let data: [TopAnime]
    public let pagination: Pagination
}
