//
//  Movie.swift
//  MoviesByLee
//
//  Created by Lee McCormick on 1/9/21.
//

import Foundation

class Movie {
    
    // Mark: -
    let title: String
    let director: String //= "Chris Nolan" >> We can also put the do a default value 
    let releaseYear: Int
    let description: String
    let rating: Double
    let moviePoster: String
    
    //director has a default value of "Chirs Nolan". Unless we specifiy otherwise, every movie that's created will have director = "Chris Nolan"
    
    init(title: String, director: String = "Chris Nolan", releaseYear: Int, description: String, rating: Double, moviePoster: String) {
        self.title = title
        self.director = director
        self.releaseYear = releaseYear
        self.description = description
        self.rating = rating
        self.moviePoster = moviePoster
    }
}
