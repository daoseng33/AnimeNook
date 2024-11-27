//
//  AnimeNookApp.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/4.
//

import SwiftUI
import JikanAPIService
import AnimeData
import SFSafeSymbols
import SwiftData

@main
struct AnimeNookApp: App {
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
    
    init() {
        StringArrayTransformer.register()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $currentTab) {
                let apiService = TopAPIService()
                let viewModel = TopContentViewModel(apiService: apiService)
                TopContentView(viewModel: viewModel)
                    .tabItem {
                        Image(systemSymbol: .house)
                        Text(TabType.home.title)
                    }
                
                let favoriteViewModel = FavoriteViewModel()
                FavoriteView(viewModel: favoriteViewModel)
                    .tabItem {
                        Image(systemSymbol: .heart)
                        Text(TabType.favorite.title)
                    }
            }
        }
        .modelContainer(for: TopAnime.self, inMemory: false)
    }
}
