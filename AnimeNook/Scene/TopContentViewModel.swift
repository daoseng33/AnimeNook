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
    private var cancellables = Set<AnyCancellable>()
    private let apiService: TopAPIServiceProtocol
    
    init(apiService: TopAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchData() {
        apiService.fetchTopAnime(type: .movie, filter: .bypopularity, rating: .rx, sfw: false, page: 1, limit: 20)
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
