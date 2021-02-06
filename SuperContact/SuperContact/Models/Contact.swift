//
//  Contact.swift
//  SuperContact
//
//  Created by Lee McCormick on 2/6/21.
//

import CloudKit
import UIKit

// MARK: - Protocol
protocol SearchableRecordDelegate {
    func matches(searchTerm: String) -> Bool
}

// MARK: - String Constant
struct ContactStrings {
    static let recordType = "Contact"
    fileprivate static let firstNameKey = "firstName"
    fileprivate static let lastNameKey = "lastName"
    fileprivate static let phoneNumberKey = "phoneNumber"
    fileprivate static let photoAssetKey = "photoAsset"
}

// MARK: - Contact Class
class Contact {
    var firstName: String
    var lastName: String?
    var phoneNumber: String?
    var recordID: CKRecord.ID
    
    var contactPhoto: UIImage? {
        get {
            guard let photoData = self.photoData else { return nil}
            return UIImage(data: photoData)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    var photoData: Data?
    var photoAsset: CKAsset? {
        get {
            guard photoData != nil else { return nil}
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            do {
                try photoData?.write(to: fileURL)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    init(firstName: String, lastName: String?, phoneNumber: String?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), contactPhoto: UIImage? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.recordID = recordID
        self.contactPhoto = contactPhoto
    }
}

// MARK: - Extension CKRecord
extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactStrings.recordType, recordID: contact.recordID)
        setValuesForKeys([
            ContactStrings.firstNameKey : contact.firstName
        ])
        if contact.lastName != nil {
            setValue(contact.lastName, forKey: ContactStrings.lastNameKey)
        }
        if contact.phoneNumber != nil {
            setValue(contact.phoneNumber, forKey: ContactStrings.phoneNumberKey)
        }
        if contact.photoAsset != nil {
            setValue(contact.photoAsset, forKey: ContactStrings.photoAssetKey)
        }
    }
}

// MARK: - Extension Contact
extension Contact {
    convenience init?(ckRecord: CKRecord) {
        guard let firstName = ckRecord[ContactStrings.firstNameKey] as? String else { return nil} //Not firstName optional, guard it.
        let lastName = ckRecord[ContactStrings.lastNameKey] as? String
        let phoneNumber = ckRecord[ContactStrings.phoneNumberKey] as? String

        var contactPhoto: UIImage?
        
        if let photoAsset = ckRecord[ContactStrings.photoAssetKey] as? CKAsset {
            do {
                guard let url = photoAsset.fileURL else { return nil}
                let data = try Data(contentsOf: url)
                contactPhoto = UIImage(data: data)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        self.init(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, recordID: ckRecord.recordID, contactPhoto: contactPhoto)
    }
}

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}

// For searching the the tableView using SearchableRecordDelegate 
extension Contact: SearchableRecordDelegate {
    func matches(searchTerm: String) -> Bool {
        if self.firstName.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else if let lastName = self.lastName, lastName.lowercased().contains(searchTerm.lowercased()) { //Because lastName? ==> if let
            return true
        } else if let phoneNumber = self.phoneNumber, phoneNumber.lowercased().contains(searchTerm.lowercased()){
            return true
        }
        return false
    }
}
