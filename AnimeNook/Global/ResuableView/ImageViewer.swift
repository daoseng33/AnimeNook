//
//  ImageViewer.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/15.
//

import SwiftUI
import SFSafeSymbols

struct ImageViewer: View {
    let imageUrl: URL?
    @Binding var isPresented: Bool
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @GestureState private var magnifyState: CGFloat = 1.0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .offset(offset)
                        .gesture(
                            MagnificationGesture()
                                .updating($magnifyState) { currentState, gestureState, _ in
                                    gestureState = currentState
                                }
                                .onChanged { value in
                                    scale = (lastScale * value).clamped(to: 1.0...4.0)
                                }
                                .onEnded { value in
                                    lastScale = scale
                                    if scale <= 1.0 {
                                        withAnimation {
                                            offset = .zero
                                            lastOffset = .zero
                                        }
                                    }
                                }
                        )
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged { value in
                                    if scale > 1.0 {
                                        let newOffset = CGSize(
                                            width: lastOffset.width + value.translation.width,
                                            height: lastOffset.height + value.translation.height
                                        )
                                        let maxOffset = (scale - 1) * geometry.size.width / 2
                                        offset = CGSize(
                                            width: newOffset.width.clamped(to: -maxOffset...maxOffset),
                                            height: newOffset.height.clamped(to: -maxOffset...maxOffset)
                                        )
                                    } else {
                                        offset = CGSize(
                                            width: 0,
                                            height: value.translation.height
                                        )
                                    }
                                }
                                .onEnded { value in
                                    if scale > 1.0 {
                                        lastOffset = offset
                                    } else {
                                        if abs(value.translation.height) > 100 {
                                            isPresented = false
                                        } else {
                                            withAnimation {
                                                offset = .zero
                                            }
                                        }
                                    }
                                }
                        )
                        .onTapGesture(count: 2) {
                            withAnimation {
                                scale = scale == 1.0 ? 2.0 : 1.0
                                lastScale = scale
                                if scale == 1.0 {
                                    offset = .zero
                                    lastOffset = .zero
                                }
                            }
                        }
                } placeholder: {
                    ProgressView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemSymbol: .xmark)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            .background(Color.black)
        }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}

#Preview {
    ImageViewer(imageUrl: URL(string: "https://cdn.myanimelist.net/images/anime/1986/145194l.jpg"),
                isPresented: .constant(true))
}
