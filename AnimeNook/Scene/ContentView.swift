//
//  ContentView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/27.
//

import SwiftUI
import JikanAPIService
import AnimeData
import SFSafeSymbols

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var currentTab: TabType = .home
    
    enum TabType {
        case home, favorite, settings
        
        var title: String {
            switch self {
            case .home: return "Home"
            case .favorite: return "Favorite"
            case .settings: return "Settings"
            }
        }
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            let apiService = TopAPIService()
            let viewModel = TopContentViewModel(apiService: apiService, modelContext: modelContext)
            TopContentView(viewModel: viewModel)
                .tabItem {
                    Image(systemSymbol: .house)
                    Text(TabType.home.title)
                }
                .tag(TabType.home)
            
            let animeStorage = DataStorage<TopAnime>(modelContext: modelContext)
            let mangaStorage = DataStorage<TopManga>(modelContext: modelContext)
            
            let favoriteViewModel = FavoriteViewModel(animeStorage: animeStorage, mangaStorage: mangaStorage)
            FavoriteView(viewModel: favoriteViewModel)
                .tabItem {
                    Image(systemSymbol: .heart)
                    Text(TabType.favorite.title)
                }
                .tag(TabType.favorite)
        }
    }
}

#Preview {
    ContentView()
}
