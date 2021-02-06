//
//  EventListTableViewController.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import UIKit

class EventListTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EventController.sharedInstance.fetchEvents()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return EventController.sharedInstance.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if EventController.sharedInstance.eventWillNotAttend.count == 0 {
                return ""
            }
            return "Will not attend."
        } else {
            if EventController.sharedInstance.eventWillAttend.count == 0 {
                return ""
            }
            return "will attend"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.sharedInstance.sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        let event = EventController.sharedInstance.sections[indexPath.section][indexPath.row]
        
        // This 2 lines below could be switch order. Does not matter.
        cell.event = event
        cell.delegate = self
        
        /* The ways to updateViweCell() using didSet or direct to updateView method.
         1) didSet method
         cell.event = event
         
         2) direct to updateView method
         cell.updateViweCell(event: event)
         */
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.sharedInstance.sections[indexPath.section][indexPath.row]
            EventController.sharedInstance.deleteEvent(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Using this function to set the hight for row at.
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return view.frame.height / 7
    //    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? EventDetailViewController else { return }
            let eventToSend = EventController.sharedInstance.sections[indexPath.section][indexPath.row]
            destinationVC.event = eventToSend
        }
    }
}

// MARK: - Extensions
extension EventListTableViewController: EventAttendedDelegate {
    func eventCellButtonTapped(sender: EventTableViewCell, event: Event, willAttend: Bool) {
        guard let event = sender.event else { return }
        EventController.sharedInstance.toggleWillAttend(event: event)
        EventController.sharedInstance.updateEventAttendedStatus(event: event)
        sender.updateViweCell()
        tableView.reloadData()
    }
}
