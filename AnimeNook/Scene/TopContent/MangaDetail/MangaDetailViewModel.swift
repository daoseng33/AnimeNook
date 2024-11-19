//
//  MangaDetailViewModel.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/19.
//

import Foundation
import JikanAPIService

final class MangaDetailViewModel {
    let title: String
    let imageURL: URL?
    let summary: String
    let type: String
    let score: String
    init(manga: TopManga) {
        title = manga.title
        imageURL = URL(string: manga.images.jpg.largeImageUrl)
        summary = manga.synopsis
        type = "Type: \(manga.type)"
        score = "Score: \(manga.score) / 10"
    }
}
