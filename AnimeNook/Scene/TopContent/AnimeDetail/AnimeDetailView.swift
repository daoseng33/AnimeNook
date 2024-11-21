//
//  AnimeDetailView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/13.
//

import SwiftUI
import Kingfisher

struct AnimeDetailView: View {
    private var viewModel: AnimeDetailViewModel
    @State private var isImageViewerPresented = false
    
    init(viewModel: AnimeDetailViewModel) {
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
                
                VStack(alignment: .leading, spacing: Constant.UI.spacing2) {
                    Text(viewModel.title)
                        .font(.headline)
                    Text(viewModel.type)
                    Text(viewModel.source)
                    Text(viewModel.rating)
                }
                .padding(EdgeInsets(top: 0, leading: Constant.UI.spacing2, bottom: 0, trailing: Constant.UI.spacing2))
                Text(viewModel.summary)
                    .padding(Constant.UI.spacing2)
            }
            .textSelection(.enabled)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .fullScreenCover(isPresented: $isImageViewerPresented) {
            ImageViewer(imageUrl: viewModel.imageURL, isPresented: $isImageViewerPresented)
        }
    }
}

#Preview {
//    let viewModel = AnimeDetailViewModel(anime: TopAnime(from: <#any Decoder#>))
//    AnimeDetailView(viewModel: viewModel)
}
