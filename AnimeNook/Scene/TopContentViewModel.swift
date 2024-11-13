//
//  TopContentViewModel.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/6.
//

import Foundation
import Combine
import JikanAPIService

final class TopContentViewModel: ObservableObject {
    @Published var topAnimes: [TopAnime] = []
    @Published var selectedType = AnimeType.movie
    @Published var selectedFilter: AnimeFilter = .bypopularity
    @Published var selectedRating: AnimeRating = .g
    @Published var loadingState: LoadingState = .initial
    private var currentPage: Int = 1
    private var cancellables = Set<AnyCancellable>()
    private let apiService: TopAPIServiceProtocol
    
    init(apiService: TopAPIServiceProtocol) {
        self.apiService = apiService
        
        setupPublisher()
    }
    
    private func setupPublisher() {
        Publishers.CombineLatest3($selectedType, $selectedFilter, $selectedRating)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .dropFirst()
            .sink { [weak self] (type, filter, rating) in
                guard let self else { return }
                reloadData()
            }
            .store(in: &cancellables)
    }
    
    func reloadData() {
        loadingState = .initial
        currentPage = 1
        fetchData()
    }
    
    func loadMoreContentIfNeeded(anime: TopAnime? = nil) {
        if let anime = anime {
            let thresholdIndex = topAnimes.index(topAnimes.endIndex, offsetBy: -1)
            if topAnimes.firstIndex(where: { $0.malId == anime.malId }) == thresholdIndex {
                fetchData()
            }
        } else {
            fetchData()
        }
    }
    
    private func fetchData() {
        guard loadingState != .loadEnd, loadingState != .loading else { return }
        
        loadingState = .loading
        
        apiService.fetchTopAnime(type: selectedType, filter: selectedFilter, rating: selectedRating, sfw: false, page: currentPage, limit: 20)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    loadingState = .success
                case .failure(let error):
                    loadingState = .failure(error)
                    print("Request failed with error: \(error)")
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                handleResponse(response)
            }
            .store(in: &cancellables)
    }
    
    private func handleResponse(_ response: AnimeResponse) {
        if response.pagination.currentPage == 1 {
            topAnimes = response.data
        } else {
            topAnimes.append(contentsOf: response.data)
        }
        
        if response.pagination.hasNextPage {
            currentPage += 1
        } else {
            loadingState = .loadEnd
        }
    }
}
