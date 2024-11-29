//
//  TopGridItem.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/11.
//

import SwiftUI
import JikanAPIService
import Kingfisher

struct TopGridItem: View {
    let imageUrl: URL?
    let title: String
    let itemWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constant.UI.spacing2) {
            KFImage(imageUrl)
                .placeholder {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: itemWidth, height: itemWidth)
                .clipShape(.rect(cornerRadius: 8))
            
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.foreground)
                .lineLimit(2)
                .frame(width: itemWidth, height: 35, alignment: .topLeading)
        }
    }
}
