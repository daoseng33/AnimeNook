//
//  ContentDetailViewModel.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/13.
//

import Foundation
import Combine
import JikanAPIService

final class ContentDetailViewModel: ObservableObject {
    let title: String
    let summary: String
    let imageUrl: URL?
    let rating: String
    let type: String
    let source: String
    
    init(anime: TopAnime) {
        title = anime.title
        summary = anime.synopsis
        imageUrl = URL(string: anime.largeImageUrl)
        rating = "Rating: \(anime.rating)"
        type = "Type: \(anime.type)"
        source = "Source: \(anime.source)"
    }
}
