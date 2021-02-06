//
//  Contact.swift
//  Summit
//
//  Created by Lee McCormick on 1/16/21.
//

import Foundation
// MARK: - Protocols
protocol SearchableRecordDelegate {
    func matches(searchTerm: String) -> Bool
}

class Contact: Codable {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var isFamily: Bool
    var uuid: String
    
    //UUID = Unit Identifier >> 25 String Character from Apple
    init(firstName: String, lastName: String, phoneNumber: String,  isFamily: Bool = false, uuid: String = UUID().uuidString) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.isFamily = isFamily
        self.uuid = uuid
    }
    
}

// MARK: - Extensions
extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Contact: SearchableRecordDelegate {
    func matches(searchTerm: String) -> Bool {
        if self.firstName.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else if self.lastName.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else if self.phoneNumber.lowercased().contains(searchTerm.lowercased()) {
            return true
        }
        return false
    }
}
