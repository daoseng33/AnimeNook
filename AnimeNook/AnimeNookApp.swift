//
//  AnimeNookApp.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/4.
//

import SwiftUI
import AnimeData
import SwiftData

@main
struct AnimeNookApp: App {
    let container: ModelContainer
    
    init() {
        StringArrayTransformer.register()
        container = try! ModelContainer(for: TopAnime.self, TopManga.self)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}
