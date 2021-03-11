//
//  Joke.swift
//  Quiz_Endgame
//
//  Created by stanley phillips on 3/8/21.
//

import Foundation

struct Joke: Decodable {
    let value: String
    let icon_url: URL?
    let categories: [String]
}
