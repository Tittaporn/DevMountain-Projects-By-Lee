//
//  ContactController.swift
//  SuperContact
//
//  Created by Lee McCormick on 2/6/21.
//


import UIKit
import CloudKit

class ContactController {
    
    // MARK: - Properties
    static let shared = ContactController()
    var contacts: [Contact] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - CRUD Methods
    // CREATE
    func saveContact(firstName: String, lastName: String?, phoneNumber: String?, contactPhoto: UIImage?, completion: @escaping (Result<Contact,NetworkError>) -> Void) {
        let contactToSave = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, contactPhoto: contactPhoto)
        let newRecord = CKRecord(contact: contactToSave)
        
        privateDB.save(newRecord) { (record, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let record = record else { return completion(.failure(.noData))}
            guard let contact = Contact(ckRecord: record) else {return completion(.failure(.unableToDecode))}
            return completion(.success(contact))
        }
    }
    
    // READ
    // Using Predicate for parameter
    func fetchContacts(predicate: NSPredicate, completion: @escaping (Result<[Contact],NetworkError>) -> Void) {
        let query = CKQuery(recordType: ContactStrings.recordType, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let records = records else {return completion(.failure(.unableToDecode))}
            let contacts = records.compactMap({ Contact(ckRecord: $0) }) //Compact Map Skip the nil value, but map will go through every $0
            completion(.success(contacts))
        }
    }
    
    // UPDATE
    // Parameters are not needed to be optional on this func.
    func updata(contact: Contact, firstName: String, lastName: String, phoneNumber: String, contactPhoto: UIImage, completion: @escaping (Result<Contact,NetworkError>) -> Void) {
        contact.firstName = firstName
        contact.lastName = lastName
        contact.phoneNumber = phoneNumber
        contact.contactPhoto = contactPhoto
        let record = CKRecord(contact: contact)
        
        let updateOperation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        updateOperation.savePolicy = .changedKeys
        // updateOperation.qualityOfService = .userInteractive ==> We don't really update it, not really update it real time in the UI.?? optional
        updateOperation.modifyRecordsCompletionBlock = { records, _ , error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let record = records?.first else { return completion(.failure(.noData))}
            guard let contact = Contact(ckRecord: record) else { return completion(.failure(.unableToDecode))}
            completion(.success(contact))
        }
        privateDB.add(updateOperation)
    }
    
    func delete(contact: Contact, completion: @escaping (Result<Bool,NetworkError>) -> Void) {
        let deleteOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [contact.recordID])
        deleteOperation.savePolicy = .changedKeys
        deleteOperation.modifyRecordsCompletionBlock = { records, _ , error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if records?.count == 0 { // Why == 0 ????, I got it the operation search through the id then got one and delete it, then the count true to be 0
                completion(.success(true))
            } else {
                return completion(.failure(.noData))
            }
        }
        privateDB.add(deleteOperation)
    }
    // DELETE
}
