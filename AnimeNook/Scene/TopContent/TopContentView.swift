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
    private let spacing: CGFloat = Constant.UI.spacing4
    private let numberOfColumns = 2
    private let scaleEffect: CGFloat = 0.85
    
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
                    mangaFilterSection
                    mangaGridSection
                }
            }
            .padding(.horizontal)
        }
        .refreshable {
            switch selectedSegment {
            case .anime:
                viewModel.reloadAnimeData()
                
            case .manga:
                viewModel.reloadMangaData()
            }
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
    
    // MARK: - Anime
    private var animeFilterSection: some View {
        HStack {
            Picker("Type", selection: $viewModel.animeSelectedType) {
                ForEach(TopAnimeType.allCases, id: \.self) { type in
                    Text(type.displayText)
                        .tag(type)
                }
            }
            .pickerStyle(.menu)
            .scaleEffect(scaleEffect)
            
            Picker("Filter", selection: $viewModel.animeSelectedFilter) {
                ForEach(TopAnimeFilter.allCases, id: \.self) { type in
                    Text(type.displayText)
                        .tag(type)
                }
            }
            .pickerStyle(.menu)
            .scaleEffect(scaleEffect)
            
            Picker("Rating", selection: $viewModel.animeSelectedRating) {
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
                    let contentDetailViewModel = AnimeDetailViewModel(anime: anime)
                    NavigationLink(destination: AnimeDetailView(viewModel: contentDetailViewModel)) {
                        TopGridItem(imageUrl: URL(string: anime.imageUrl), title: anime.title, itemWidth: itemWidth)
                            .onAppear {
                                viewModel.loadMoreAnimeIfNeeded(anime: anime)
                            }
                    }
                }
            }
            .onAppear {
                viewModel.loadMoreAnimeIfNeeded()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    // MARK: - Manga
    private var mangaFilterSection: some View {
        HStack {
            Picker("Type", selection: $viewModel.mangaSelectedType) {
                ForEach(TopMangaType.allCases, id: \.self) { type in
                    Text(type.displayText)
                        .tag(type)
                }
            }
            .pickerStyle(.menu)
            .scaleEffect(scaleEffect)
            
            Picker("Filter", selection: $viewModel.mangaSelectedFilter) {
                ForEach(TopMangaFilter.allCases, id: \.self) { type in
                    Text(type.displayText)
                        .tag(type)
                }
            }
            .pickerStyle(.menu)
            .scaleEffect(scaleEffect)
        }
    }
    
    private var mangaGridSection: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(viewModel.topMangas, id: \.malId) { manga in
                    let mangaViewModel = MangaDetailViewModel(manga: manga)
                    NavigationLink(destination: MangaDetailView(viewModel: mangaViewModel)) {
                        TopGridItem(imageUrl: URL(string: manga.images.jpg.imageUrl), title: manga.title, itemWidth: itemWidth)
                            .onAppear {
                                viewModel.loadMoreMangaIfNeeded(manga: manga)
                            }
                    }
                }
            }
            .onAppear {
                viewModel.loadMoreMangaIfNeeded()
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
