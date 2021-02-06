//
//  NotificationScheduler.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import UserNotifications

class NotificationScheduler {
    func scheduleNotifications(event: Event) {
        guard let eventDate = event.eventDate,
              let id = event.id else { return }
        let content = UNMutableNotificationContent()
        content.title = "YO DAWG"
        content.body = "Still want to go to \(event.name ?? "your event.")"
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: eventDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        
    }
    
    func cancelNotifcations(event: Event) {
        guard let id = event.id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
