//
//  QuizResult+Convenience.swift
//  quizTeam
//
//  Created by Lee McCormick on 3/8/21.
//

import Foundation
import CoreData

extension QuizResult {
    
    @discardableResult convenience init(name: String, score: Int, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.score = Int64(Int(score))
    }
}
