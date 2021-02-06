//
//  ContactDetailViewController.swift
//  SuperContact
//
//  Created by Lee McCormick on 2/6/21.
//

import UIKit

class ContactDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var deleteContactButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        deleteContactButton.isHidden = false
    }
    
    // MARK: - Properties
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            deleteContactButton.isHidden = false
        }
    }
    
    var selectedImage: UIImage?

    // MARK: - Actions
    @IBAction func deleleteButtonTapped(_ sender: Any) {
        presentDeleteButtonAlertController() 
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let contactPhoto = selectedImage else { self.presentTextFieldAlertController(); return } //If NO firstName and contactPhoto, pop the alert for user.
        
        let lastName = lastNameTextField.text ?? "" // because the lastName is optional
        let phoneNumber = phoneNumberTextField.text ?? ""
        
        if let contact = contact {
            ContactController.shared.updata(contact: contact, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, contactPhoto: contactPhoto) { (result) in
                self.switchOnResult(result)
            }
        } else {
            ContactController.shared.saveContact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, contactPhoto: contactPhoto) { (result) in
                self.switchOnResult(result)
            }
        }
    }
    
    
    // MARK: - Helper Fuctions
    func updateUI() {
        guard let contact = contact else { return }
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        phoneNumberTextField.text = contact.phoneNumber
    }
    
    func switchOnResult(_ result: Result<Contact,NetworkError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(_):
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self.presentErrorToUser(localizedError: error)
            }
        }
    }
    
    func presentTextFieldAlertController() {
        let alert = UIAlertController(title: "Please fill out all required fields", message: "First name and Photo", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func presentDeleteButtonAlertController() {
        let alert = UIAlertController(title: "Delete Contact", message: "Are you sure about that?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        let confirmAction = UIAlertAction(title: "Yeah, I hate this person.", style: .destructive) { (_) in
            guard let contact = self.contact else {return}
            ContactController.shared.delete(contact: contact) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        print("Contact \(contact.firstName) succesfully deleted.")
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        self.presentErrorToUser(localizedError: error)
                    }
                }
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoPickerView" {
            let destinationVC = segue.destination as? PhotoPickerViewController
            destinationVC?.delegate = self
            guard let photo = self.contact?.contactPhoto else {return}
            destinationVC?.contactPhoto = self.contact?.contactPhoto
            self.selectedImage = photo
            
        }
    }
}

// MARK: - Extensions
extension ContactDetailViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
       selectedImage = image
    }
}
