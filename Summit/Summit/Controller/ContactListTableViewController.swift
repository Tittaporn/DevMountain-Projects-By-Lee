//
//  ContactListTableViewController.swift
//  Summit
//
//  Created by Lee McCormick on 1/16/21.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    // MARK: - Properties
    var isSearching: Bool = false
    var resultsArray: [SearchableRecordDelegate] = []
    static let sharedInstance = ContactListTableViewController()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        contactSearchBar.delegate = self
        ContactController.sharedInstance.loadFromPersistance()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ContactListTableViewController.sharedInstance.resultsArray = ContactController.sharedInstance.contacts
        contactSearchBar.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactListTableViewController.sharedInstance.resultsArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell

        guard let contact = ContactListTableViewController.sharedInstance.resultsArray[indexPath.row] as? Contact else { return UITableViewCell()}
        cell?.delegate = self
        cell?.updateViews(for: contact)
        return cell ?? UITableViewCell()
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? ContactDetailViewController else { return }
            let contactToSend = ContactListTableViewController.sharedInstance.resultsArray[indexPath.row]
            destinationVC.contact = contactToSend as? Contact
        }
    }
}


extension ContactListTableViewController: ContactListCellDelegate {
    func isFamilyButtonTapped(for sender: ContactTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        guard let contact = ContactListTableViewController.sharedInstance.resultsArray[indexPath.row] as? Contact else { return }
        ContactController.sharedInstance.toggleIsFamily(contact: contact)
        sender.updateViews(for: contact)
    }
}

extension ContactListTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            ContactListTableViewController.sharedInstance.resultsArray = ContactController.sharedInstance.contacts.filter { $0.matches(searchTerm: searchText) }
            self.tableView.reloadData()
        } else {
            ContactListTableViewController.sharedInstance.resultsArray = ContactController.sharedInstance.contacts
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        isSearching = false
        ContactListTableViewController.sharedInstance.resultsArray = ContactController.sharedInstance.contacts
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
    }
}
