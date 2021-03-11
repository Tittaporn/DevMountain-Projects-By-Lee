//
//  QuizResultController.swift
//  quizTeam
//
//  Created by Lee McCormick on 3/8/21.
//

import CoreData


class QuizResultController {
    static let shared = QuizResultController()
    
    var quizResults: [QuizResult] = []
    
    private lazy var fetchRequest: NSFetchRequest<QuizResult> = {
           let request = NSFetchRequest<QuizResult>(entityName: "QuizResult")
           request.predicate = NSPredicate(value: true)
        
           return request
       }()

    func createQuizResult(name: String, score: Int) {
        let quizResult = QuizResult(name: name, score: score)
        quizResults.append(quizResult)
    }
    
    func fetchQuizResults() {
        let fetchQuizResults = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        quizResults = fetchQuizResults
    }
}
