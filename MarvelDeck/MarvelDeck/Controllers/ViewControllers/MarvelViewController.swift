//
//  MarvelViewController.swift
//  MarvelDeck
//
//  Created by Lee McCormick on 1/30/21.
//

import UIKit

class MarvelViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var characterSearchBar: UISearchBar!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var fetchCommicButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCommicButton.isHidden = true
        characterSearchBar.delegate = self
    }
    
    // MARK: - Properties
    var character: MarvelCharacter?
    
    // MARK: - Actions
    @IBAction func fetchCommitButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Methods
    func fetchImageAndUpdateUI(for marvelCharacter: MarvelCharacter) {
        MarvelCharacterController.fetchThumbnail(for: marvelCharacter) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.characterImageView.image = image
                case .failure(let error):
                    self.characterImageView.image = UIImage(named: "forest")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toComicListVC" {
            guard let destinationVC = segue.destination as? ComicListTableViewController else { return }
            destinationVC.character = self.character
        }
        
    }
}

// MARK: - Extensions
extension MarvelViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Make sure !searchTerm.isEmpty to prevent the "" String
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return }
        MarvelCharacterController.fetchMarvelCharacter(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    self.character = character
                    self.fetchCommicButton.isHidden = false
                    self.characterNameLabel.text = character.name
                    self.characterDescriptionLabel.text = character.description
                    self.fetchImageAndUpdateUI(for: character)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
} //End of extensions


