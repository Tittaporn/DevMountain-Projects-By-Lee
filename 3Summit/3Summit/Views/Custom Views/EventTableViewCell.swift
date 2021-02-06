//
//  EventTableViewCell.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import UIKit

// MARK: - Protocol
protocol EventAttendedDelegate: AnyObject {
    func eventCellButtonTapped(sender: EventTableViewCell, event: Event, willAttend: Bool)
    
}

// MARK: - Class
class EventTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var willAttendButton: UIButton!
    
    // MARK: - Properties
    // didSet == Properties Obeserver, Watch and observer when the property is been set.
    // using didSet >> Could be benefit of saving memory.
    var event: Event? { // event was set, then run updateViewCell.
        didSet {
            updateViweCell()
        }
    }
    
    /*
     2 way to updateViewCell()
     1) using didSet
     2) updateViewCell() on EventListTVC directly
     */
    
    // Assign Type of delegate
    weak var delegate: EventAttendedDelegate?
    
    var willAttend = false
    
    // MARK: - Actions
    @IBAction func willAttendedButtonTapped(_ sender: Any) {
        guard let event = event else { return }
       
        willAttend.toggle()
        
        // Assign the instruction for the real delegate
        delegate?.eventCellButtonTapped(sender: self, event: event, willAttend: willAttend)
    }
    
    // MARK: - Methods
    func updateViweCell() {
        guard let event = event else { return }
        eventNameLabel.text = event.name
        eventDateLabel.text = event.eventDate?.formatToString()
        let image = event.willAttend ? "willAttend" : "willNotAttend"
        willAttendButton.setImage(UIImage(named: image), for: .normal)
    }
}


/* NOTE
 Swift Property Observers

 var event: Event? { // event was set, then run updateViewCell.
     didSet {
         print("Old Value: \(String(describing: oldValue))")
         updateViweCell()
     } willSet {
         print("New Value: \(String(describing: newValue))")
     }
 }
 
 Why use a Property Observer?
 Back in Objective-C, if you wanted to do any special handling for setting a property, you would have to override the setter, reimplement the actual value setting (that was originally done for you), and then add whatever you wanted to do besides that, like posting a notification of a change.  Swift’s property observers save you from having to reimplement the setter in those cases.

 Property Observers are somewhat similar to computed properties.  You can read more about those in my previous article Computed Properties in Swift.  For computed properties, you write custom code for the getter and setter.  For property observers, you write custom code only for setting, for right before (willSet) and right after (didSet).  The main purpose of Swift’s property observers is to watch for when a property is set.  As such, property observers are only useful for variables (var properties), and cannot be written for constants (let properties).

 How to Implement Property Observers
 There are two very appropriately named property observers in Swift: willSet, and didSet.  They are called exactly when you think they would be, right before and right after setting, respectively.  On top of this, they are also implicitly given constants describing the newValue and oldValue respectively.

 willSet comes with a constant parameter that contains the new value, with the default name newValue
 didSet comes with a constant parameter that contains the old value, with the default name oldValue
 You can override either of those names, if you wish, but if no name is provided, the defaults are used.

 Say we had a Swift String property.  This property is set often in some program, but not always to a different value.  If this String is set to the same value, just let things continue as if nothing happened (because really, not much did).  If the String gets a new value though, we need to post a notification for another class to update based off of that new value.  That is a great time to use Swift’s property observers!
 
 Property Observers are not called during Initialization
 This was mentioned in my previous post, but I will mention it again here.  In Swift, the property observers are NOT called during initialization or when a default value is set.  I’m not sure if it sets the backing variable directly, or if there is a flag set that suppresses the property observers (the iBook seems to suggest the former), but either way, they are not called when variables are written to from an initializer or with a default value.
 
 Conclusion
 While property observers aren’t the biggest feature in Swift, they do have their place.  They can be quite useful for value change notifications.  They also can be used to keep related values in sync if you don’t want to use a computed property (such as if computing the related value each time it is requested was computationally expensive).
 
 https://www.codingexplorer.com/swift-property-observers/
 https://nshipster.com/swift-property-observers/
 
 
 */
