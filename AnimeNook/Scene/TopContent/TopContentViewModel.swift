//
//  TopContentViewModel.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/6.
//

import Foundation
import Combine
import JikanAPIService
import AnimeData
import SwiftUI

final class TopContentViewModel: ObservableObject {
    @Published var topAnimes: [TopAnime] = []
    @Published var animeSelectedType = TopAnimeType.tv
    @Published var animeSelectedFilter: TopAnimeFilter = .byPopularity
    @Published var animeSelectedRating: TopAnimeRating = .g
    @Published var animeLoadingState: LoadingState = .initial
    @Published var topMangas: [TopManga] = []
    @Published var mangaSelectedType = TopMangaType.manga
    @Published var mangaSelectedFilter: TopMangaFilter = .byPopularity
    @Published var mangaLoadingState: LoadingState = .initial
    private var animeCurrentPage: Int = 1
    private var mangaCurrentPage: Int = 1
    private var cancellables = Set<AnyCancellable>()
    private let apiService: TopAPIServiceProtocol
    
    init(apiService: TopAPIServiceProtocol) {
        self.apiService = apiService
        
        setupPublisher()
    }
    
    private func setupPublisher() {
        Publishers.CombineLatest3($animeSelectedType, $animeSelectedFilter, $animeSelectedRating)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .dropFirst()
            .sink { [weak self] (type, filter, rating) in
                guard let self else { return }
                reloadAnimeData()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($mangaSelectedType, $mangaSelectedFilter)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .dropFirst()
            .sink { [weak self] (type, filter) in
                guard let self else { return }
                reloadMangaData()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Top Anime
    func reloadAnimeData() {
        animeLoadingState = .initial
        animeCurrentPage = 1
        fetchTopAnimeData()
    }
    
    func loadMoreAnimeIfNeeded(anime: TopAnime? = nil) {
        if let anime = anime {
            let thresholdIndex = topAnimes.index(topAnimes.endIndex, offsetBy: -5)
            if topAnimes.firstIndex(where: { $0.malId == anime.malId }) == thresholdIndex {
                fetchTopAnimeData()
            }
        } else {
            fetchTopAnimeData()
        }
    }
    
    private func fetchTopAnimeData() {
        guard animeLoadingState != .loadEnd, animeLoadingState != .loading else { return }
        
        animeLoadingState = .loading
        
        apiService.fetchTopAnime(type: animeSelectedType, filter: animeSelectedFilter, rating: animeSelectedRating, sfw: false, page: animeCurrentPage, limit: 20)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    animeLoadingState = .success
                case .failure(let error):
                    animeLoadingState = .failure(error)
                    print("Request failed with error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                handleTopAnimeResponse(response)
            })
            .store(in: &cancellables)
    }
    
    private func handleTopAnimeResponse(_ response: TopAnimeResponse) {
        if response.pagination.currentPage == 1 {
            topAnimes = response.data
        } else {
            topAnimes.append(contentsOf: response.data)
        }
        
        if response.pagination.hasNextPage {
            animeCurrentPage += 1
        } else {
            animeLoadingState = .loadEnd
        }
    }
    
    // MARK: - Top Manga
    func reloadMangaData() {
        mangaLoadingState = .initial
        mangaCurrentPage = 1
        fetchTopMangaData()
    }
    
    func loadMoreMangaIfNeeded(manga: TopManga? = nil) {
        if let manga = manga {
            let thresholdIndex = topMangas.index(topMangas.endIndex, offsetBy: -5)
            if topMangas.firstIndex(where: { $0.malId == manga.malId }) == thresholdIndex {
                fetchTopMangaData()
            }
        } else {
            fetchTopMangaData()
        }
    }
    
    func fetchTopMangaData() {
        guard mangaLoadingState != .loadEnd, mangaLoadingState != .loading else { return }
        
        mangaLoadingState = .loading
        
        apiService.fetchTopManga(type: mangaSelectedType, filter: mangaSelectedFilter, page: mangaCurrentPage, limit: 20)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    mangaLoadingState = .success
                    
                case .failure(let error):
                    mangaLoadingState = .failure(error)
                    print("Request failed with error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                handleTopMangaResponse(response)
            })
            .store(in: &cancellables)
    }
    
    private func handleTopMangaResponse(_ response: TopMangaResponse) {
        if response.pagination.currentPage == 1 {
            topMangas = response.data
        } else {
            topMangas.append(contentsOf: response.data)
        }
        
        if response.pagination.hasNextPage {
            mangaCurrentPage += 1
        } else {
            mangaLoadingState = .loadEnd
        }
    }
}
