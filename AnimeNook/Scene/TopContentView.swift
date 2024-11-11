//
//  TopContentView.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/4.
//

import SwiftUI
import JikanAPIService

struct TopContentView: View {
    // MARK: - Property
    @StateObject private var viewModel: TopContentViewModel
    private let spacing: CGFloat = 16
    private let numberOfColumns = 2
    
    private var itemWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - (spacing * 2)
        return (availableWidth - (spacing * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
    }
    
    private var columns: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
    }
    
    // MARK: - Init
    init(viewModel: TopContentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            filterSection
            animeGridSection
        }
        .refreshable {
            viewModel.fetchData()
        }
    }
    
    private var filterSection: some View {
        HStack {
            Picker("Type", selection: $viewModel.selectedType) {
                ForEach(AnimeType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Picker("Filter", selection: $viewModel.selectedFilter) {
                ForEach(AnimeFilter.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Picker("Rating", selection: $viewModel.selectedRating) {
                ForEach(AnimeRating.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(.horizontal)
    }
    
    private var animeGridSection: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(viewModel.topAnimes, id: \.malId) { anime in
                    AnimeGridItem(anime: anime, itemWidth: itemWidth)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    let apiService = TopAPIService()
    let viewModel = TopContentViewModel(apiService: apiService)
    TopContentView(viewModel: viewModel)
}
