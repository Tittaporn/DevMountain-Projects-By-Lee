//
//  MovieController.swift
//  MoviesByLee
//
//  Created by Lee McCormick on 1/9/21.
//

import Foundation

class MovieController {
    static var movies: [Movie] {
        
        let pulpFiction = Movie(title: "Pulp Fiction", director: "Quentin Tarantino", releaseYear: 1994, description: "The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption", rating: 8.9, moviePoster: "pulpFiction")
        
        let boondoockSaints = Movie(title: "The Boondock Saints", director: "Troy Duffy", releaseYear: 1999, description: "Two Irish Catholic brothers become vigilantes and wipe out Boston's criminal underworld in the name of God", rating: 7.8, moviePoster: "boondockSaints")
        
        let waterboy = Movie(title: "Waterboy",director: "Frank Coraci", releaseYear: 1998, description: "A waterboy for a college football team discovers he has a unique tackling ability and becomes a member of the team.", rating: 6.2, moviePoster: "waterboy")
        
        let happyGilmore = Movie(title: "Happy Gilmore", director: "Dennis Dugan", releaseYear: 1996, description: "All Happy Gilmore (Adam Sandler) has ever wanted is to be a professional hockey player. But he soon discovers he may actually have a talent for playing an entirely different sport: golf. When his grandmother (Frances Bay) learns she is about to lose her home, Happy joins a golf tournament to try and win enough money to buy it for her. With his powerful driving skills and foulmouthed attitude, Happy becomes an unlikely golf hero -- much to the chagrin of the well-mannered golf professionals.", rating: 93, moviePoster: "happyGilmore")
        
        let ninteenSeventeen = Movie(title: "1917", director: "Sam Mendes", releaseYear: 2019, description: "April 6th, 1917. As a regiment assembles to wage war deep in enemy territory, two soldiers are assigned to race against time and deliver a message that will stop 1,600 men from walking straight into a deadly trap.", rating: 8.3, moviePoster: "ninteenSeventeen")
        
        
        let tenet = Movie(title: "Tenet", releaseYear: 2020, description: "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.", rating: 10.0, moviePoster: "tenet")
        
        return [pulpFiction, boondoockSaints, waterboy,happyGilmore,ninteenSeventeen,tenet]
    }
}
