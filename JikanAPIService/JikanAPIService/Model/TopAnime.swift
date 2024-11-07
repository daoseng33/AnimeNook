//
//  TopAnime.swift
//  JikanAPIService
//
//  Created by DAO on 2024/11/5.
//

import Foundation

public struct TopAnime: Decodable {
    public let malId: Int
    public let url: String
    public let imageUrl: String
    public let smallImageUrl: String
    public let title: String
    
    private enum CodingKeys: String, CodingKey {
        case malId, url, images, title
    }
    
    private enum ImagesKeys: String, CodingKey {
        case jpg
    }
    
    private enum JpgKeys: String, CodingKey {
        case imageUrl, smallImageUrl
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        malId = try container.decode(Int.self, forKey: .malId)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        
        let imagesContainer = try container.nestedContainer(keyedBy: ImagesKeys.self, forKey: .images)
        let jpgContainer = try imagesContainer.nestedContainer(keyedBy: JpgKeys.self, forKey: .jpg)
        
        imageUrl = try jpgContainer.decode(String.self, forKey: .imageUrl)
        smallImageUrl = try jpgContainer.decode(String.self, forKey: .smallImageUrl)
    }
}
