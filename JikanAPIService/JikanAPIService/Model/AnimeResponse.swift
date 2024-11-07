//
//  AnimeResponse.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation

public struct AnimeResponse: Decodable {
    public let data: [TopAnime]
    public let pagination: Pagination
}
