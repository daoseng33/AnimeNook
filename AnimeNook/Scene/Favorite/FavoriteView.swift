//
//  FavoriteView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/20.
//

import SwiftUI
import Combine

struct FavoriteView: View {
    @StateObject private var viewModel: FavoriteViewModel
    private let spacing: CGFloat = Constant.UI.spacing4
    private let numberOfColumns = 2
    private var itemWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - (spacing * 2)
        return (availableWidth - (spacing * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
    }
    
    private var columns: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
    }
    
    init(viewModel: FavoriteViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                pickerSection
                
                switch viewModel.selectedSegment {
                case .anime:
                    animeGridSection
                case .manga:
                    mangaGridSection
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var pickerSection: some View {
        Picker("FavoritePicker", selection: $viewModel.selectedSegment) {
            ForEach(NavigationSegment.allCases, id: \.self) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var animeGridSection: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach($viewModel.favoriteAnimes, id: \.malId) { anime in
                    let anime = anime.wrappedValue
                    let contentDetailViewModel = AnimeDetailViewModel(anime: anime, storage: viewModel.animeStorage)
                    let animeDetailView =
                    AnimeDetailView(viewModel: contentDetailViewModel)
                        .toolbar(.hidden, for: .tabBar)
                    NavigationLink(destination: animeDetailView) {
                        TopGridItem(imageUrl: URL(string: anime.images.jpg.imageUrl), title: anime.title, itemWidth: itemWidth)
                    }
                }
            }
            .onAppear {
                viewModel.fetchAnimeDatas()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var mangaGridSection: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach($viewModel.favoriteMangas, id: \.malId) { manga in
                    let manga = manga.wrappedValue
                    let mangaViewModel = MangaDetailViewModel(manga: manga, storage: viewModel.mangaStorage)
                    let mangaDetailView =
                    MangaDetailView(viewModel: mangaViewModel)
                        .toolbar(.hidden, for: .tabBar)
                    NavigationLink(destination: mangaDetailView) {
                        TopGridItem(imageUrl: URL(string: manga.images.jpg.imageUrl), title: manga.title, itemWidth: itemWidth)
                    }
                }
            }
            .onAppear {
                viewModel.fetchMangaDatas()
            }
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    let favoriteViewModel = FavoriteViewModel(modelContext: <#ModelContext#>)
//    FavoriteView(viewModel: favoriteViewModel)
//}
