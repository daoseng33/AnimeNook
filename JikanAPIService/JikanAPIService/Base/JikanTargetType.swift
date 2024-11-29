//
//  JikanTargetType.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation
import Moya

protocol JikanTargetType: TargetType { }

extension JikanTargetType {
    public var baseURL: URL {
        return URL(string: "https://api.jikan.moe/v4")!
    }
}
