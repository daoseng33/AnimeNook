//
//  AnimeNookApp.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/4.
//

import SwiftUI
import JikanAPIService

@main
struct AnimeNookApp: App {
    var body: some Scene {
        WindowGroup {
            let apiService = TopAPIService()
            let viewModel = TopContentViewModel(apiService: apiService)
            TopContentView(viewModel: viewModel)
        }
    }
}
