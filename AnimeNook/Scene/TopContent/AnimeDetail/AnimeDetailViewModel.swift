//
//  AnimeDetailViewModel.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/13.
//

import Foundation
import JikanAPIService

final class AnimeDetailViewModel {
    let title: String
    let summary: String
    let imageURL: URL?
    let rating: String
    let type: String
    let source: String
    
    init(anime: TopAnime) {
        title = anime.title
        summary = anime.synopsis
        imageURL = URL(string: anime.largeImageUrl)
        rating = "Rating: \(anime.rating)"
        type = "Type: \(anime.type)"
        source = "Source: \(anime.source)"
    }
}
