//
//  Joke.swift
//  quizTeam
//
//  Created by Lee McCormick on 3/8/21.
//

import Foundation


struct Joke: Decodable {
    let value: String
    let icon_url: URL?
    let categories: [String]
}
