//
//  MangaDetailView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/19.
//

import SwiftUI
import Kingfisher
import SFSafeSymbols
import Combine

struct MangaDetailView: View {
    private let viewModel: MangaDetailViewModel
    @State private var isImageViewerPresented = false
    @State private var heartSymbol: SFSymbol = .heart
    @State private var cancelables: Set<AnyCancellable> = []
    
    init(viewModel: MangaDetailViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupPublisher() {
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { isFavorite in
                heartSymbol = isFavorite ? .heartFill : .heart
            }
            .store(in: &cancelables)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                KFImage(viewModel.imageURL)
                    .fade(duration: 0.3)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        isImageViewerPresented = true
                    }
                VStack(alignment: .leading, spacing: Constant.UI.spacing2) {
                    HStack {
                        Text(viewModel.title)
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.isFavorite.toggle()
                        }) {
                            Image(systemSymbol: heartSymbol)
                                .foregroundStyle(.red)
                                .font(.system(size: 25))
                        }
                    }
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
            .textSelection(.enabled)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .fullScreenCover(isPresented: $isImageViewerPresented) {
            ImageViewer(imageUrl: viewModel.imageURL, isPresented: $isImageViewerPresented)
        }
        .onAppear() {
            setupPublisher()
        }
    }
}

//#Preview {
//    MangaDetailView()
//}
