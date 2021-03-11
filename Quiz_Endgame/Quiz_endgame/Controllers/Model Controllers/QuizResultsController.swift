//
//  QuizResultsController.swift
//  Quiz_Endgame
//
//  Created by stanley phillips on 3/8/21.
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
        CoreDataStack.saveContext()
    }
    
    func fetchQuizResults() {
        let fetchQuizResults = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        let sortedQuizResults = fetchQuizResults.sorted(by: {$0.score > $1.score })
        quizResults = sortedQuizResults
    }
}
