//
//  EventAttended+Convenience.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import CoreData

extension EventAttended {
    @discardableResult convenience init(event: Event, attendedStatus: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.event = event
        self.attendedStatus = attendedStatus
    }
}
