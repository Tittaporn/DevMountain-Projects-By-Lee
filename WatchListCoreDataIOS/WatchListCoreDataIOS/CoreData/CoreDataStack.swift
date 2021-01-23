//
//  CoreDataStack.swift
//  WatchListCoreDataIOS
//
//  Created by Lee McCormick on 1/21/21.
//

import CoreData

enum CoreDataStack {
    
    // MARK: - Container
    // The container is the bank
    static let container: NSPersistentContainer = {
        
        // create file in a folder and the name that folder.
        let container = NSPersistentContainer(name: "WatchListCoreDataIOS")//Alway update the name. This name has to match .xcdatamodeld and the project
        
        //Using completion handler just enter.
        container.loadPersistentStores { (_, error) in
            if let error = error { //continal upwarping using if let. if we have error, it error is not nil, we are going to do something here.
                
                //if an error, just crash the app and print out error
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        
        //if no error, just return container
        return container
    }()
    
    // MARK: - Context
    //Thsis is the counter in the bank
    //create context from the container that we just created.
    static var context: NSManagedObjectContext { container.viewContext }
    
    // MARK: - SaveContext
    //Go to the valut and save money
    //save the context when the context has changed.
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save() //if the function is throws, using do try catch.
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
