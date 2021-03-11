//
//  JokeViewController.swift
//  quizTeam
//
//  Created by Lee McCormick on 3/8/21.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var addNewJokeButton: UIButton!
    // MARK: - Properties
    var categories: [String] = []
    var pickData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        fetchJoke(catagory: "animal")    }
    
    @IBAction func newJokeButtonTapped(_ sender: Any) {
        guard let catagory = categories.randomElement() else { return }
        fetchJoke(catagory: catagory)
    }
    
    // MARK: - Helper Fuctions
    func fetchJoke(catagory: String) {
        JokeController.fetchJoke(catagory: catagory) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let joke):
                    self.updateViews(joke: joke)
                case .failure(let error):
                    print("Error!\(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchCategories() {
        JokeController.fetchCategories { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.categories = categories
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    func updateViews(joke: Joke) {
        jokeLabel.text = joke.value
    }
}
