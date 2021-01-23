//
//  Show.swift
//  WatchList
//
//  Created by Lee McCormick on 1/14/21.
//

import Foundation

class Show: Codable {  //Codable using when you convert to and from JSON. OR Pull information from database. OR Working with API. Persistence == SAVING AND LOADIND
  
    var title: String
    var haveWatched:Bool
    init(title: String, haveWatched: Bool = false) {
        self.title = title
        self.haveWatched = haveWatched
    }
}

extension Show: Equatable {
    static func == (lhs: Show, rhs: Show) -> Bool {
        lhs.title == rhs.title && lhs.haveWatched == rhs.haveWatched
        
        // lhs.title === rhs.title >> compare every single aspect.
    }
}


