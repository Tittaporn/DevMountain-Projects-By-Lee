//
//  User+Convenience.swift
//  Quiz_Endgame
//
//  Created by stanley phillips on 3/8/21.
//

import CoreData

extension QuizResult {
    @discardableResult convenience init(name: String, score: Int, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.score = Int64(Int(score))
    }
}
