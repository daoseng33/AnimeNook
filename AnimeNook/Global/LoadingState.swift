//
//  LoadingState.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/12.
//

import Foundation

enum LoadingState: Equatable {
    case initial
    case loading
    case success
    case failure(Error)
    case loadEnd
    
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
            switch (lhs, rhs) {
            case (.initial, .initial),
                 (.loading, .loading),
                 (.success, .success),
                 (.loadEnd, .loadEnd):
                return true
            case (.failure, .failure):
                return true
            default:
                return false
            }
        }
}
