//
//  ContactTableViewCell.swift
//  Summit
//
//  Created by Lee McCormick on 1/16/21.
//

import UIKit

// MARK: - Protocol
protocol ContactListCellDelegate: class {
    func isFamilyButtonTapped(for sender: ContactTableViewCell)
}

class ContactTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var isFamilyButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: ContactListCellDelegate?
    
    // MARK: - Actions
    @IBAction func toggleIsFamily(_ sender: Any) {
        delegate?.isFamilyButtonTapped(for: self)
    }
    
    // MARK: - Helper Fuctions
    func updateButton(isFamily: Bool) {
        let buttonTitle = isFamily ? "family" : "friend"
        isFamilyButton.setTitle(buttonTitle, for: .normal)
    }
    
    func updateViews(for contact: Contact) {
        contactNameLabel.text = "\(contact.firstName) \(contact.lastName)"
        updateButton(isFamily: contact.isFamily)
    }
}
