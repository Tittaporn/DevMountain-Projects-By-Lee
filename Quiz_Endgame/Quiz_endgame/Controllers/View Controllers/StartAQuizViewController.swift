//
//  StartAQuizViewController.swift
//  Quiz_Endgame
//
//  Created by stanley phillips on 3/8/21.
//

import UIKit

class StartAQuizViewController: UIViewController {
    @IBOutlet weak var chuckJokeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var categories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 8
        fetchCategories()
        fetchJoke(catagory: "animal")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let catagory = categories.randomElement() else { return }
        fetchJoke(catagory: catagory)
    }
    
    
    @IBAction func startQuizButtonTapped(_ sender: Any) {
        guard let quizVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "quiz") as? QuizViewController else {return}
        
        
        quizVC.modalPresentationStyle = .overCurrentContext
        present(quizVC, animated: true, completion: nil)
    }
    
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
        chuckJokeLabel.text = joke.value
    }
    
}//end class
