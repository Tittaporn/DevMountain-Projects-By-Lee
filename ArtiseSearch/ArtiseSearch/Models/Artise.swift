//
//  Artise.swift
//  ArtiseSearch
//
//  Created by Lee McCormick on 1/28/21.
//

import Foundation

// https://api.musixmatch.com/ws/1.1/artist.search?q_artist=sam&apikey=7c69e27301441fe3d6fc6a977b97fb53

struct TopLevelObject: Decodable {
    let message: SecondLevelObject
}

struct SecondLevelObject: Decodable {
    let body: ThirdLevelObject
}

struct ThirdLevelObject: Decodable {
    let artistList: [FourthLevelObject]
    private enum CodingKeys: String, CodingKey {
        case artistList = "artist_list"
    }
}

struct FourthLevelObject: Decodable {
    let artist: Artist
}

struct Artist: Decodable {
    let artistName: String
    let artistTwitterURL: String
    private enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case artistTwitterURL = "artist_twitter_url"
    }
}
