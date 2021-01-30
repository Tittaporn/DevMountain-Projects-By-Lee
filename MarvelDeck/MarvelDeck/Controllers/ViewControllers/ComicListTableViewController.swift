//
//  ComicListTableViewController.swift
//  MarvelDeck
//
//  Created by Lee McCormick on 1/30/21.
//

import UIKit

class ComicListTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComics()
    }
    
    // MARK: - Properties
    var character: MarvelCharacter?
    var comics: [Comic.Data.Result] = []
    
    // MARK: - Methods
    func fetchComics() {
        guard let character = character else { return }
        // String(character.id) == String >> Int to String
        ComicController.fetchMarvelCommics(characterID: String(character.id)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let comics):
                    self.comics = comics
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicCell", for: indexPath) as? ComicTableViewCell
        let comic = comics[indexPath.row]
        //        cell.textLabel?.text = comic.title
        //        cell.detailTextLabel?.text = "Price: \(comic.prices[0].price)"
        
        cell?.updateViews(comic: comic)
        
        return cell ?? UITableViewCell() //Using nil coalesing instead of guard the cell.
    }
    
}
