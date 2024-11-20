//
//  MangaDetailView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/19.
//

import SwiftUI
import Kingfisher
import SFSafeSymbols

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
                VStack(alignment: .leading, spacing: Constant.UI.spacing2) {
                    Text(viewModel.type)
                    HStack(spacing: Constant.UI.spacing1) {
                        Image(systemSymbol: .starFill)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.yellow)
                        Text(viewModel.score)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: Constant.UI.spacing2, bottom: 0, trailing: Constant.UI.spacing2))
                Text(viewModel.summary)
                    .padding(Constant.UI.spacing2)
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
