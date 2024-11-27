//
//  MangaDetailViewModel.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/19.
//

import Foundation
import AnimeData
import SwiftData
import Combine

@MainActor
final class MangaDetailViewModel: ObservableObject {
    let title: String
    let imageURL: URL?
    let summary: String
    let type: String
    let score: String
    @Published var isFavorite: Bool = false
    private var storage: DataStorage<TopManga>
    private let manga: TopManga
    private var cancelables: Set<AnyCancellable> = []
    
    init(manga: TopManga, modelContext: ModelContext) {
        self.manga = manga
        title = manga.title
        imageURL = URL(string: manga.images.jpg.largeImageUrl)
        summary = manga.synopsis
        type = "Type: \(manga.type)"
        score = "\(manga.score)"
        storage = DataStorage(modelContext: modelContext)
        
        checkManga()
        setupPublisher()
    }
    
    func checkManga() {
          Task {
              let existingManga = try? await storage.fetchOne(predicate: #Predicate<TopManga> { item in
                  item.malId == manga.malId
              })
              
              isFavorite = existingManga != nil
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
                        try? await storage.create(manga)
                    } else {
                        try? await storage.delete(manga)
                    }
                    
                    let manga = try? await storage.fetch()
                    print("ray>> manga: \(manga)")                    
                }
            }
            .store(in: &cancelables)
    }
}
