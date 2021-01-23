//
//  ShowListTableViewController.swift
//  WatchListCoreDataIOS
//
//  Created by Lee McCormick on 1/21/21.
//

import UIKit

class ShowListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowController.shared.fetchShows()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        // HERE IF RETURN nil IS OK.
        presentAlertController(for: nil)
    }
    
    // MARK: - Helper Methods
    
    // (for show: Show?) >> for update.
    func presentAlertController(for show: Show?) {
        // if you create in CURD >> DO NOT NEED parameter
        // if you update >> NEED parameter
        let alart = UIAlertController(title: "Add Show", message: "What you wanna watch?", preferredStyle: .alert)
        
        // (action) >> named we can pick in completionHandler. >> Do Anything in the handler and give us the product before get out the {Completion Handler}
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            // This line for adding textFields[0] == first TextFields, [1] == seconded textField
            guard let showTitle = alart.textFields?[0].text, !showTitle.isEmpty else { return }
            if let show = show {
                ShowController.shared.updateShowWith(show: show, title: showTitle)
                self.tableView.reloadData()
            } else {
                ShowController.shared.createShowWith(title: showTitle)
                self.tableView.reloadData()
            }
        }
        
        // .destructive >> make it red.
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        // Don't forget to add TextField >> (_) because it is only one textField, we don't care to name it.
        alart.addTextField { (_) in }
        alart.addAction(addButton)
        alart.addAction(cancelButton)
        
        self.present(alart, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShowController.shared.shows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowTableViewCell else { return UITableViewCell() }
        
        let show = ShowController.shared.shows[indexPath.row]
        
        // update Show Cell before assign the delegate
        cell.updateWith(show: show)
        cell.delegate = self
        
        return cell
    }
    
    // Click on the cell and pop up alert.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let show = ShowController.shared.shows[indexPath.row]
        presentAlertController(for: show)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let showToDelete = ShowController.shared.shows[indexPath.row]
            ShowController.shared.deleteShow(show: showToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ShowListTableViewController: ShowTableViewCellDelegate {
    func buttonTapped(sender: ShowTableViewCell) {
        
        // Find the indexPath for sender == the cell tableView.indexPath(for: sender)
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        // find the show to toggle
        let showToToggle = ShowController.shared.shows[indexPath.row]
        
        // toggled it.
        ShowController.shared.toggleHaveWatched(show: showToToggle)
        
        // always updateViews..
        sender.updateWith(show: showToToggle)
    }
}
