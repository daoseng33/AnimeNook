//
//  AnimeDetailViewModel.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/13.
//

import Foundation
import AnimeData
import Combine
import SwiftUICore
import SwiftData

@MainActor
final class AnimeDetailViewModel: ObservableObject {
    let title: String
    let summary: String
    let imageURL: URL?
    let rating: String
    let type: String
    let source: String
    private let anime: TopAnime
    @Published var isFavorite: Bool = false
    private var cancelables: Set<AnyCancellable> = []
    private var storage: DataStorage<TopAnime>
    
    init(anime: TopAnime, modelContext: ModelContext) {
        self.anime = anime
        title = anime.title
        summary = anime.synopsis
        imageURL = URL(string: anime.images.jpg.largeImageUrl)
        rating = "Rating: \(anime.rating)"
        type = "Type: \(anime.type)"
        source = "Source: \(anime.source)"
        storage = DataStorage(modelContext: modelContext)
        
        checkAnime(anime: anime)
        setupPublisher()
    }
    
    func checkAnime(anime: TopAnime) {
          Task {
              let existingAnime = try? await storage.fetchOne(predicate: #Predicate<TopAnime> { item in
                  item.malId == anime.malId
              })
              
              isFavorite = existingAnime != nil
          }
      }
    
    private func setupPublisher() {
        $isFavorite
            .dropFirst(2)
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] isFavorite in
                guard let self else { return }
                
                Task {
                    if isFavorite {
                        try? await storage.create(anime)
                    } else {
                        try? await storage.delete(anime)
                    }
                }
            }
            .store(in: &cancelables)
    }
}
