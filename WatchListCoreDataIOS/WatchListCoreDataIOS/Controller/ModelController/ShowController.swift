//
//  ShowController.swift
//  WatchListCoreDataIOS
//
//  Created by Lee McCormick on 1/21/21.
//

import CoreData //The CoreData include Foundation

class ShowController {
    
    // MARK: - Properties
    static let shared = ShowController()
    var shows: [Show] = []
    
    // building papar slip, hey go get me that I need in my vault.
    // <Show> We want Show back.
    private lazy var fetchRequest: NSFetchRequest<Show> = {
        let request = NSFetchRequest<Show>(entityName: "Show")
        
        // MAY BE NOT NEED THIS LINE. BECAUSE UPPER LINE SHOULD GET EVERYTHING IN SHOW. MAY BE !!!!!! NOT SURE.
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD Methods
    // CREATE
    func createShowWith(title: String){
        // Show(title: title) >> Can use this one, but cause the problem on VC when we need data from S.O.T.
        let newShow = Show(title: title)
        shows.append(newShow)
        CoreDataStack.saveContext()
    }
    
    // READ
    func fetchShows(){
        shows  = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func updateShowWith(show: Show, title: String) {
        show.title = title
        CoreDataStack.saveContext()
    }
    
    func toggleHaveWatched(show: Show) {
        show.haveWatched.toggle()
        CoreDataStack.saveContext()
    }
    
    // DELETE
    func deleteShow(show: Show) {
        // ONLY DELETE IN CORE DATA >> DO NOT NEED TO FIND first indexOf and delete from arrays. >> if we use index to delete from S.O.T. Then delete from CoreDataStack. Should work the same.
        CoreDataStack.context.delete(show)
        CoreDataStack.saveContext()
        fetchShows() //TO DISPLAY ALL SHOWS
        // If you use CoreDataStack.context.delete(show) >> Theb fetch >> it populate new S.O.T.
    }
}

/* NOTE
 
 2 TYPE of Property in Swift.
 1) store property >> store data.
 2) computed property >> calculate and store in the property.
 ____________________________________________________________________________
 
 Check this out....
 
 NSHipster is a journal of the overlooked bits in Objective-C, Swift, and Cocoa.
 https://nshipster.com/
 */
