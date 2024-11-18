//
//  ContentDetailView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/13.
//

import SwiftUI
import JikanAPIService
import Kingfisher

struct ContentDetailView: View {
    @StateObject private var viewModel: ContentDetailViewModel
    @State private var isImageViewerPresented = false
    
    init(viewModel: ContentDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                KFImage(viewModel.imageUrl)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        isImageViewerPresented = true
                    }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.type)
                    Text(viewModel.source)
                    Text(viewModel.rating)
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                Text(viewModel.summary)
                    .padding(8)
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbarRole(.editor)
        .fullScreenCover(isPresented: $isImageViewerPresented) {
            ImageViewer(imageUrl: viewModel.imageUrl, isPresented: $isImageViewerPresented)
        }
    }
}

#Preview {
//    let viewModel = ContentDetailViewModel(anime: TopAnime(from: <#any Decoder#>))
//    ContentDetailView(viewModel: viewModel)
}
