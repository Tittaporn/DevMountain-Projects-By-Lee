//
//  ContactDetailViewController.swift
//  Summit
//
//  Created by Lee McCormick on 1/16/21.
//

import UIKit

class ContactDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var deleteContactButton: UIButton!
    
    // MARK: - Properties
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            print("Contact \(contact?.firstName ?? "") was sent to the detail view.")
            deleteContactButton.isHidden = false
        }
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        deleteContactButton.isHidden = true
    }
    
    
    // MARK: - Actions
    
    @IBAction func deleteContactTapped(_ sender: Any) {
        presentDeleteButtonAlertController()
    }
    
    @IBAction func saveContactButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else { return }
        
        if let contact = contact {
            ContactController.sharedInstance.updateContact(contact: contact, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        } else {
            ContactController.sharedInstance.createContact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Fuctions
    func updateUI() {
        guard let contact = contact else { return }
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        phoneNumberTextField.text = contact.phoneNumber
    }
    
    func presentDeleteButtonAlertController() {
        let alert = UIAlertController(title: "Delete Contact", message: "Are you sure you want to delete this contact?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        let confirmAction = UIAlertAction(title: "Yeah, I hate this person.", style: .destructive) { (_) in
            guard let contact = self.contact else { return }
            ContactController.sharedInstance.deleteContact(contactToDelete: contact)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
}
