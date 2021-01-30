//
//  Comic.swift
//  MarvelDeck
//
//  Created by Lee McCormick on 1/30/21.
//

import Foundation

// This way is easy to named it of the name we use in struct instead of topLevel

struct Comic: Codable {
    let code: Int
    let status: String
    let data: Data
    
    struct Data: Codable {
        let total: Int //API have many 1765 pages, but every time we call only get 20 pages at a time
        let count: Int
        let results: [Result]
        
        struct Result: Codable {
            let id: Int
            let title: String
            let pageCount: Int
            let prices: [Price]
            let thumbnail: Thumbnail
            
            struct Price: Codable {
                let type: String
                let price: Double
            }
            
            struct Thumbnail: Codable {
                let path: URL
                let `extension`: String
            }
        }
    }
}
