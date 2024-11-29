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
    private let anime: TopAnime
    private let storage: DataStorage<TopAnime>
    let title: String
    let summary: String
    let imageURL: URL?
    let rating: String
    let type: String
    let source: String
    @Published var isFavorite: Bool = false
    private var cancelables: Set<AnyCancellable> = []
    
    init(anime: TopAnime, storage: DataStorage<TopAnime>) {
        self.anime = anime
        self.storage = storage
        title = anime.title
        summary = anime.synopsis
        imageURL = URL(string: anime.images.jpg.largeImageUrl)
        rating = "Rating: \(anime.rating)"
        type = "Type: \(anime.type)"
        source = "Source: \(anime.source)"
        
        checkAnime(anime: anime)
        setupPublisher()
    }
    
    func checkAnime(anime: TopAnime) {
          Task {
              do {
                  let existingAnime = try await storage.fetchOne(predicate: #Predicate<TopAnime> { item in
                      item.malId == anime.malId
                  })
                  isFavorite = existingAnime != nil
              } catch {
                  print("Fetch Error: \(error.localizedDescription)")
                  isFavorite = false
              }
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
                    do {
                        if isFavorite {
                            try await storage.create(anime)
                        } else {
                            try await storage.delete(anime)
                        }
                    } catch {
                        print("Storage Error: \(error.localizedDescription)")
                    }
                }
            }
            .store(in: &cancelables)
    }
}
