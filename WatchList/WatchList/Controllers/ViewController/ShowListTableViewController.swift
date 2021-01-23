//
//  ShowListTableViewController.swift
//  WatchList
//
//  Created by Lee McCormick on 1/14/21.
//

import UIKit

class ShowListTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowController.shared.loadFromPersistance()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Show", message: "Whatcha tryna watch?", preferredStyle: .alert)
        
        //completion handler >> if this done, we gonna do what inside for you.
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //alert.textFields?[0] >> adding textField in AlertController
            guard let newShowTitle = alert.textFields?[0].text, !newShowTitle.isEmpty else { return }
        
            //using ShowController to create new show
            ShowController.shared.createShowWith(title: newShowTitle)
            
            self.tableView.reloadData()
        }
        
        //if you delete the completion handler, you need to let the code reviewer knows that we don't need anything to do after alert
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (_) in}
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        //present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShowController.shared.myShows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // guard againt this, if this happens do this in return. If not continue out side the return.
        // as? Optionally casting >> Cast the showCell as? ShowTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowTableViewCell else {return UITableViewCell()}
        
        let show = ShowController.shared.myShows[indexPath.row]
        
        // telling cell to delegate
        cell.updateWith(show: show)
        
        // STEP 4: Assign Delegate //PROTOCOL AND DELEGATE
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //Access the show to delete
            let showToDelete = ShowController.shared.myShows[indexPath.row]
            
            //Delete show using the delete function
            ShowController.shared.deleteShow(show: showToDelete)
            
            //Animation how to display
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Extension ShowTableViewCellDelegate
// STEP 3:  Conform Delegate //PROTOCOL AND DELEGATE
extension ShowListTableViewController: ShowTableViewCellDelegate {
    
    //using the protocol
    func buttonTapped(sender: ShowTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let showToToggle = ShowController.shared.myShows[indexPath.row]
        
        ShowController.shared.toggleHaveWatch(show: showToToggle)
        
        sender.updateWith(show: showToToggle)
    }
}
