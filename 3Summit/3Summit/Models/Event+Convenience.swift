//
//  Event+Convenience.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import CoreData

extension Event {
    // @discardableResult >> Can come back nil or fail >> Based to how to want to change the stuff. You can build the code without using it  @discardableResult.
    // No willAttend here ????
    @discardableResult convenience init(id: String = UUID().uuidString, name: String, eventDate: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = id
        self.name = name
        self.eventDate = eventDate
    }
}
