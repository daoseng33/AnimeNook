//
//  MangaDetailView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/19.
//

import SwiftUI
import Kingfisher

struct MangaDetailView: View {
    private let viewModel: MangaDetailViewModel
    @State private var isImageViewerPresented = false
    
    init(viewModel: MangaDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                KFImage(viewModel.imageURL)
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
                    Text(viewModel.score)
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
            ImageViewer(imageUrl: viewModel.imageURL, isPresented: $isImageViewerPresented)
        }
    }
}

//#Preview {
//    MangaDetailView()
//}
