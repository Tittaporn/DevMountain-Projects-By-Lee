//
//  YakListTableViewController.swift
//  YikyYak
//
//  Created by Lee McCormick on 2/4/21.
//

import UIKit

class YakListTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        fetchYaks()
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "YIKKK YAKKK", message: "Share your post", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Put your quote here..."
        }
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Who said it..."
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let postAction = UIAlertAction(title: "Post", style: .default) { (_) in
            guard let text = alertController.textFields?[0].text,
                  let author = alertController.textFields?[1].text,
                  !text.isEmpty, !author.isEmpty else { return }
            YakController.shared.createYak(with: text, author: author) { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response)
                        self?.tableView.reloadData()
                    case .failure(let error):
                        print(error.errorDescription ?? "Error updating.")
                    }
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(postAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Helper Fuctions
    func fetchYaks() {
        YakController.shared.fetchAllYaks { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.errorDescription ?? "Error Fetching All Yaks.")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YakController.shared.yaks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "yakCell", for: indexPath) as? YakTableViewCell else { return UITableViewCell() }
        let yak = YakController.shared.yaks[indexPath.row]
        cell.yak = yak
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let yakToDelete = YakController.shared.yaks[indexPath.row]
            guard let index = YakController.shared.yaks.firstIndex(of: yakToDelete) else { return }
            YakController.shared.delete(yak: yakToDelete) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response)
                        YakController.shared.yaks.remove(at: index)
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                    case .failure(let error):
                        print(error.errorDescription ?? "Error deleting.")
                    }
                }
            }
           
        }
    }
}
