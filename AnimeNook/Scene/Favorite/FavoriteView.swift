//
//  FavoriteView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/20.
//

import SwiftUI
import Combine

struct FavoriteView: View {
    @StateObject var viewModel: FavoriteViewModel
    
    init(viewModel: FavoriteViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let favoriteViewModel = FavoriteViewModel()
    FavoriteView(viewModel: favoriteViewModel)
}
