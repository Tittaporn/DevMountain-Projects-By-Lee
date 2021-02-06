//
//  ContactController.swift
//  Summit
//
//  Created by Lee McCormick on 1/16/21.
//

import Foundation

class ContactController {
    
    // MARK: - Properties
    static let sharedInstance = ContactController()
    // S.O.T
    var contacts: [Contact] = []
    
    // MARK: - Methods
    func createContact(firstName: String, lastName: String, phoneNumber: String) {
        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        contacts.append(newContact)
        saveToPersistence()
    }
    
    func updateContact(contact: Contact, firstName: String,lastName: String, phoneNumber: String) {
        contact.firstName = firstName
        contact.lastName = lastName
        contact.phoneNumber = phoneNumber
        saveToPersistence()
    }
    
    func deleteContact(contactToDelete: Contact) {
        guard let indexToDelete = contacts.firstIndex(of: contactToDelete) else {return}
        contacts.remove(at: indexToDelete)
        saveToPersistence()
    }
    
    func toggleIsFamily(contact: Contact){
        //contact.isFamily = !contact.isFamily
        contact.isFamily.toggle() //We can use this toggle for swift true or false
        saveToPersistence()
    }
    
    // MARK: - Persistence
    // CREATE
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Contact.json")
        return fileURL
    }
    
    // SAVE
    func saveToPersistence() {
        do {
            let data = try JSONEncoder().encode(contacts)
            try data.write(to: createFileForPersistence())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // LOAD
    func loadFromPersistance() {
        do {
            let data = try Data(contentsOf: createFileForPersistence())
            contacts = try JSONDecoder().decode([Contact].self, from: data)
            ContactListTableViewController.sharedInstance.resultsArray = contacts
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
