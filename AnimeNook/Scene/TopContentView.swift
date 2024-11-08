//
//  TopContentView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/4.
//

import SwiftUI
import JikanAPIService

struct TopContentView: View {
    @StateObject private var viewModel: TopContentViewModel
    
    init(viewModel: TopContentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Picker("Type", selection: $viewModel.selectedOption) {
                    ForEach(AnimeType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView {
                let spacing: CGFloat = 16
                let numberOfColumns = 2
                
                let screenWidth = UIScreen.main.bounds.width
                
                let itemWidth: CGFloat = {
                    let availableWidth = screenWidth - (spacing * 2)
                    return (availableWidth - (spacing * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
                }()
                
                let columns: [GridItem] = {
                    return Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
                }()
                
                LazyVGrid(columns: columns, spacing: spacing) {
                    ForEach(viewModel.topAnimes, id: \.malId) { anime in
                        VStack(alignment: .leading, spacing: 8) {
                            AsyncImage(url: URL(string: anime.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                            }
                            .frame(width: itemWidth, height: itemWidth)
                            .clipShape(.rect(cornerRadius: 8))
                            
                            Text(anime.title)
                                .font(.system(size: 14, weight: .medium))
                                .lineLimit(2)
                                .frame(width: itemWidth, height: 35, alignment: .topLeading)
                        }
                    }
                }
                .padding(.horizontal)
                .onAppear {
                    viewModel.fetchData()
                }
            }
        }
    }
}

#Preview {
    let apiService = TopAPIService()
    let viewModel = TopContentViewModel(apiService: apiService)
    TopContentView(viewModel: viewModel)
}
