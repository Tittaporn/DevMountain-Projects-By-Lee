//
//  EventController.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import CoreData

class EventController {
    
    // MARK: - Properties
    static let sharedInstance = EventController()
    
    // notifications
    let notificationScheduler = NotificationScheduler()
    
    // Properties for section
    var sections: [[Event]] {[eventWillNotAttend,eventWillAttend]}
    var eventWillNotAttend: [Event] = []
    var eventWillAttend: [Event] = []
    
    // MARK: - Fetch Request
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD Methods
    // CREATE
    func createEvent(name: String, eventDate: Date) {
        let newEvent = Event(name: name, eventDate: eventDate)
        eventWillAttend.append(newEvent)
        CoreDataStack.saveContext()
    }
    
    // READ
    func fetchEvents() {
        let events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        eventWillAttend = events.filter{$0.willAttend == true}
        eventWillNotAttend = events.filter{$0.willAttend == false}
    }
    
    // UPDATE
    func updateEvent(event: Event, name: String, eventDate: Date) {
        event.name = name
        event.eventDate = eventDate
        
        // notifications
        notificationScheduler.cancelNotifcations(event: event)
        notificationScheduler.scheduleNotifications(event: event)
        
        CoreDataStack.saveContext()
    }
    
    func toggleWillAttend(event: Event) {
        event.willAttend.toggle()
        CoreDataStack.saveContext()
    }
    
    func updateEventAttendedStatus(event: Event) {
        if event.willAttend { // Take out from one list to another list.
            if let index = eventWillNotAttend.firstIndex(of: event) {
                eventWillNotAttend.remove(at: index)
                eventWillAttend.append(event) //If it is true, add to the attendedEvents.
                // notifications
                notificationScheduler.scheduleNotifications(event: event)
            }
        } else {
            if let index = eventWillAttend.firstIndex(of: event) {
                eventWillAttend.remove(at: index)
                eventWillNotAttend.append(event) //If it is false, add to the unattendedEvents
                notificationScheduler.cancelNotifcations(event: event)
            }
        }
        CoreDataStack.saveContext()
    }
    
    // DELETE
    func deleteEvent(event: Event){
        CoreDataStack.context.delete(event)
        print("\(#file)\(#line)")
        // notifications
        notificationScheduler.cancelNotifcations(event: event)
        
        CoreDataStack.saveContext()
        fetchEvents() // ?
    }
}



 
