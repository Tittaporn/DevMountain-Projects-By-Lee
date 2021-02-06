//
//  EventDetailViewController.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    // MARK: - Properties
       var event: Event?

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let eventName = eventNameTextField.text, !eventName.isEmpty else  { return }
              let eventDate = eventDatePicker.date
        if let event = event {
            EventController.sharedInstance.updateEvent(event: event, name: eventName, eventDate: eventDate)
        } else {
            EventController.sharedInstance.createEvent(name: eventName, eventDate: eventDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let event = event else { return }
        titleLabel.text = "Update Event"
        eventNameTextField.text = event.name
        eventDatePicker.date = event.eventDate ?? Date()
    }
}
