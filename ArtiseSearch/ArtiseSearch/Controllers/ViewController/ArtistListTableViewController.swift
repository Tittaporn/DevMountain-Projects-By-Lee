//
//  ArtistListTableViewController.swift
//  ArtiseSearch
//
//  Created by Lee McCormick on 1/28/21.
//

import UIKit

class ArtistListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var artists: [Artist] = []
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath)
        let artist = artists[indexPath.row]
        cell.textLabel?.text = artist.artistName
        cell.detailTextLabel?.text = artist.artistTwitterURL
        return cell
    }
}

// MARK: - extension UISearchBarDelegate
extension ArtistListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        ArtistController.fetchArtist(WithSearchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let artists):
                    self.artists = artists
                    self.tableView.reloadData()
                // if we needed to fetch image or something here, we can call helper function here...
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
    // For Every Single that you type, it will search in the data. USE textDidChange
    // >> func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)

