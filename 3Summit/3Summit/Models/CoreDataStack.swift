//
//  CoreDataStack.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import CoreData

enum CoreDataStack {
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "_Summit")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context in \(#function) : \(error.localizedDescription)")
            }
        }
    }
}

