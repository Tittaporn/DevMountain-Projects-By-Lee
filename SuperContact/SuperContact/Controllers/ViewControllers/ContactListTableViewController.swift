//
//  ContactListTableViewController.swift
//  SuperContact
//
//  Created by Lee McCormick on 2/6/21.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        contactSearchBar.delegate = self
        fetchAllContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Properties
    var resultsArray: [SearchableRecordDelegate] = []
    var isSearching = false
    
    
    // MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        fetchAllContacts()
    }
    
// MARK: - Helper Fuctions
    func fetchAllContacts() {
        let predicate = NSPredicate(value: true)
        ContactController.shared.fetchContacts(predicate: predicate) { (result) in
            switch result {
            case .success(let contacts):
                ContactController.shared.contacts = contacts.sorted(by: {$0.firstName.lowercased() < $1.firstName.lowercased()})
                self.resultsArray = ContactController.shared.contacts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell
        
        // as? Contact else { return UITableViewCell()} because
        // ==> var resultsArray: [SearchableRecordDelegate] = []
        
        guard let contact = resultsArray[indexPath.row] as? Contact else { return UITableViewCell()}
        cell?.setupCell(contact: contact)
        return cell ?? UITableViewCell()
    }
 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indextPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? ContactDetailViewController else { return }
            let contactToSend = resultsArray[indextPath.row]
            destinationVC.contact = contactToSend as? Contact
        }
    }

}

// MARK: - Extensions
extension ContactListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            resultsArray = ContactController.shared.contacts.filter { $0.matches(searchTerm: searchText) }
            self.tableView.reloadData()
        } else {
            resultsArray = ContactController.shared.contacts
            self.tableView.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() //Resign the keyboard when user done.
        searchBar.text = ""
        isSearching = false
        resultsArray = ContactController.shared.contacts
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

