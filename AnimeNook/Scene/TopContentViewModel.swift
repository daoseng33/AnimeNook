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
    private var cancellables = Set<AnyCancellable>()
    private let apiService: TopAPIServiceProtocol
    
    
    init(apiService: TopAPIServiceProtocol) {
        self.apiService = apiService
        
        setupPublisher()
    }
    
    private func setupPublisher() {
        Publishers.CombineLatest3($selectedType, $selectedFilter, $selectedRating)
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .sink { [weak self] (type, filter, rating) in
                self?.fetchData()
            }
            .store(in: &cancellables)
    }
    
    func fetchData() {
        apiService.fetchTopAnime(type: selectedType, filter: selectedFilter, rating: selectedRating, sfw: false, page: 1, limit: 20)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Request completed successfully")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            } receiveValue: { [weak self] response in
                print("Received anime response: \(response)")
                self?.topAnimes = response.data
            }
            .store(in: &cancellables)
    }
}
