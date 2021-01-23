//
//  Show+Convenience.swift
//  WatchListCoreDataIOS
//
//  Created by Lee McCormick on 1/21/21.
//

import CoreData

// struct have init buit-in. like this coreData of WatchListCoreDataIOS

extension Show {
    // convenience make you more convenience to access to this class.
    @discardableResult convenience init(title: String, haveWatched: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.haveWatched = haveWatched
    }
}
