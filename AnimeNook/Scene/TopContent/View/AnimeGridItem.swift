//
//  AnimeGridItem.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/11.
//

import SwiftUI
import JikanAPIService
import Kingfisher

struct AnimeGridItem: View {
    let anime: TopAnime
    let itemWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            KFImage(URL(string: anime.imageUrl))
                .placeholder {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: itemWidth, height: itemWidth)
                .clipShape(.rect(cornerRadius: 8))
            
            Text(anime.title)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(2)
                .frame(width: itemWidth, height: 35, alignment: .topLeading)
        }
    }
}
