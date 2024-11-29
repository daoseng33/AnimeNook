//
//  FavoriteViewModel.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/20.
//

import Foundation
import SwiftData
import AnimeData

@MainActor
final class FavoriteViewModel: ObservableObject {
    let animeStorage: DataStorage<TopAnime>
    let mangaStorage: DataStorage<TopManga>
    @Published var favoriteAnimes: [TopAnime] = []
    @Published var favoriteMangas: [TopManga] = []
    @Published var selectedSegment: NavigationSegment = .anime
    
    init(animeStorage: DataStorage<TopAnime>, mangaStorage: DataStorage<TopManga>) {
        self.animeStorage = animeStorage
        self.mangaStorage = mangaStorage
    }
    
    func fetchAnimeDatas() {
        Task {
            do {
                favoriteAnimes = try await animeStorage.fetch()
            } catch {
                print("Fetch data error: \(error)")
            }
        }
    }
    
    func fetchMangaDatas() {
        Task {
            do {
                favoriteMangas = try await mangaStorage.fetch()
            } catch {
                print("Fetch data error: \(error)")
            }
        }
    }
}
