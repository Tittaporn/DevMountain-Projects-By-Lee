//
//  MarvelCharacter.swift
//  MarvelDeck
//
//  Created by Lee McCormick on 1/30/21.
//

import Foundation

struct TopLevelObject: Codable {
    let data: SecondLevelObject
}

struct SecondLevelObject: Codable {
    let results: [MarvelCharacter]
}

struct MarvelCharacter: Codable {
    let name: String
    let description: String
    let id: Int
    let thumbnailInfo: ThumbnailInfo
    
    enum CodingKeys: String, CodingKey{
        case name
        case description
        case id
        case thumbnailInfo = "thumbnail"
    }
}

struct ThumbnailInfo: Codable {
    let path: URL
    let `extension`: String //`something` turn xCode keyword to you own version
}
