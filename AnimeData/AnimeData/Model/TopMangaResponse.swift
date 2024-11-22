//
//  TopMangaResponse.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/18.
//

import Foundation

public struct TopMangaResponse: Decodable {
    public let data: [TopManga]
    public let pagination: Pagination
    
    public init(data: [TopManga], pagination: Pagination) {
        self.data = data
        self.pagination = pagination
    }
}
