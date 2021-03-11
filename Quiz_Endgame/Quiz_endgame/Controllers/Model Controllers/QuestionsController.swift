//
//  QuestionsController.swift
//  Quiz_Endgame
//
//  Created by stanley phillips on 3/8/21.
//

import Foundation

class QuestionController {
    static let shared = QuestionController()

    let quiz = [
        Question(q: "Lee lives in Chicago.", a: "True"),
        Question(q: "Dennis Speaks Spanish.", a: "True"),
        Question(q: "Stan has been snowboarding for 12 years.", a: "True"),
        Question(q: "Max Said this was the best group ever.", a: "True"),
        Question(q: "Lee was born in Thailand.", a: "True"),
        Question(q: "Dennis was born in Russia.", a: "True"),
        Question(q: "Lee loves padthai.", a: "False"),
        Question(q: "Max P is a fan of Avatar the last Airbender?", a: "True"),
        Question(q: "Stan is currently living in Peru", a: "True"),
        Question(q: "Dennis is allergic to pufferfish.", a: "False"),
        Question(q: "Max was wrong about something once", a: "False"),
        Question(q: "Stan is originally from Texas.", a: "True"),
        Question(q: "Once when he was little Dennis was ran over by a horse", a: "True"),
        Question(q: "Lee likes to listen to hard screamo music", a: "False"),
        Question(q: "Stan is actually 6'11", a: "False")
    ]
    
    func randomize() -> [Question] {
        return quiz.shuffled()
    }
}
