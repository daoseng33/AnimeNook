//
//  TopContentView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/4.
//

import SwiftUI
import JikanAPIService

struct TopContentView: View {
    // MARK: - Property
    @StateObject private var viewModel: TopContentViewModel
    @State private var selectedSegment: NavigationSegment = .anime
    private let spacing: CGFloat = 16
    private let numberOfColumns = 2
    
    private var itemWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - (spacing * 2)
        return (availableWidth - (spacing * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
    }
    
    private var columns: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
    }
    
    enum NavigationSegment: String, CaseIterable {
        case anime = "Anime"
        case manga = "Manga"
    }
    
    // MARK: - Init
    init(viewModel: TopContentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack {
                pickerSection
                
                switch selectedSegment {
                case .anime:
                    animeFilterSection
                    animeGridSection
                    
                case .manga:
                    Rectangle()
                }
            }
            .padding(.horizontal)
        }
        .refreshable {
            viewModel.reloadData()
        }
    }
    
    private var pickerSection: some View {
        Picker("Type", selection: $selectedSegment) {
            ForEach(NavigationSegment.allCases, id: \.self) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var animeFilterSection: some View {
        HStack {
            let scaleEffect: CGFloat = 0.85
            
            Picker("Type", selection: $viewModel.selectedType) {
                ForEach(TopAnimeType.allCases, id: \.self) { type in
                    Text(type.displayText)
                        .tag(type)
                }
            }
            .pickerStyle(.menu)
            .scaleEffect(scaleEffect)
            
            Picker("Filter", selection: $viewModel.selectedFilter) {
                ForEach(TopAnimeFilter.allCases, id: \.self) { type in
                    Text(type.displayText)
                        .tag(type)
                }
            }
            .pickerStyle(.menu)
            .scaleEffect(scaleEffect)
            
            Picker("Rating", selection: $viewModel.selectedRating) {
                ForEach(TopAnimeRating.allCases, id: \.self) { type in
                    Text(type.displayText)
                        .tag(type)
                }
            }
            .pickerStyle(.menu)
            .scaleEffect(scaleEffect)
        }
    }
    
    private var animeGridSection: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(viewModel.topAnimes, id: \.malId) { anime in
                    let contentDetailViewModel = ContentDetailViewModel(anime: anime)
                    NavigationLink(destination: ContentDetailView(viewModel: contentDetailViewModel)) {
                        TopGridItem(imageUrl: URL(string: anime.imageUrl), title: anime.title, itemWidth: itemWidth)
                            .onAppear {
                                viewModel.loadMoreContentIfNeeded(anime: anime)
                            }
                    }
                }
            }
            .onAppear {
                viewModel.loadMoreContentIfNeeded()
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let apiService = TopAPIService()
    let viewModel = TopContentViewModel(apiService: apiService)
    TopContentView(viewModel: viewModel)
}
