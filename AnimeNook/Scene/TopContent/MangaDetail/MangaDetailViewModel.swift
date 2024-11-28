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
    private let storage: DataStorage<TopManga>
    private let manga: TopManga
    private var cancelables: Set<AnyCancellable> = []
    
    init(manga: TopManga, storage: DataStorage<TopManga>) {
        self.manga = manga
        self.storage = storage
        title = manga.title
        imageURL = URL(string: manga.images.jpg.largeImageUrl)
        summary = manga.synopsis
        type = "Type: \(manga.type)"
        score = "\(manga.score)"
        
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
                    do {
                        if isFavorite {
                            try await storage.create(manga)
                        } else {
                            try await storage.delete(manga)
                        }
                    } catch {
                        print("Storage Error: \(error.localizedDescription)")
                    }
                }
            }
            .store(in: &cancelables)
    }
}
