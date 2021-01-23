//
//  ShowController.swift
//  WatchList
//
//  Created by Lee McCormick on 1/14/21.
//

import Foundation

class ShowController { //Class Decoration >> Now it is exist in our app.
    
    // MARK: - Properties
    //Shared Instance
    static let shared = ShowController() //init this shared is created at the same time that ShowController created it.
    
    //S.O.T.
    var myShows: [Show] = [] //Empty to make sure with the app, if it is okay with no data in it.
    
    // MARK: - CRUD Methods
    
    //CREATE
    func createShowWith(title: String) { // Don't need `haveWatched: <#T##Bool#>` because this app has default value.
        let newShow = Show(title: title)
        myShows.append(newShow) //we appended to S.O.T Array to display later in the tableView
        saveToPersistence()
    }
    
    //DELETE
    func deleteShow(show: Show) { //using show to find the index
        guard let indexToDelete = myShows.firstIndex(of: show) else {return} //guard let help break out of this and skip the line before. And go do something else in the app..
        myShows.remove(at: indexToDelete)
        saveToPersistence()
    }
    
    //UPDATE
    func toggleHaveWatch(show: Show){
        show.haveWatched = !show.haveWatched //fliping on and off >> ture to false or false to true
        
        saveToPersistence()
        // >> show.haveWatched.toggle() //For switch on and off. We can use .toggle() Not in this case
    }
    
    // MARK: - Persistence
    // CREATE
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Show.json")
        return fileURL //retrun the address for the path of file
    }
    
    // .default >> Mostly something with Persistence
    
    
    // SAVE
    func saveToPersistence() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(myShows) // Try to find myShow and encode it to JSON
            try data.write(to: createFileForPersistence()) // Write in the file that we created on createFileForPersistence()
        } catch { //automatic catch error
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // LOAD
    func loadFromPersistance() {
        let jsondecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: createFileForPersistence()) // Try to find JSON data in the file
            // Always put .self when decode
            myShows = try jsondecoder.decode([Show].self, from: data) // Decode the data and show or load in Show Type.
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

