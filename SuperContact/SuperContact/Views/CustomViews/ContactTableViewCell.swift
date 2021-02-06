//
//  ContactTableViewCell.swift
//  SuperContact
//
//  Created by Lee McCormick on 2/6/21.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var contactPhotoImageView: RoundedImage!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactphoneNumberLabel: UILabel!
    
    // MARK: - Methods
    func setupCell(contact: Contact) {
        contactPhotoImageView.image = contact.contactPhoto
        contactNameLabel.text = contact.phoneNumber
        contactphoneNumberLabel.text = contact.phoneNumber
        
        if let lastName = contact.lastName {
            contactNameLabel.text = "\(contact.firstName) \(lastName)"
        } else {
            contactNameLabel.text = contact.firstName
        }
    }
}
