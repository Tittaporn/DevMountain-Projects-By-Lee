//
//  QuizRestulTableListViewController.swift
//  quizTeam
//
//  Created by Lee McCormick on 3/8/21.
//

import UIKit

class QuizRestulTableListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    
    @IBAction func addQuizResultButtonTapped(_ sender: Any) {
        
    }
    
    
    func presentQuizCompleteAlert() {
      
        
        let alertController = UIAlertController(title: "", message: "Your score is out of . \n Enter name to save high score.", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name..."
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Score..."
        }
    
        let dismissAction = UIAlertAction(title: "Ok", style: .default) { (action) in
           
            guard let name = alertController.textFields?[0].text,
                  let scoreString = alertController.textFields?[1].text else {return}
           let score = Int(scoreString) ?? 0
            
            QuizResultController.shared.createQuizResult(name: name, score: score)
        }
        alertController.addAction(dismissAction)
        alertController.popoverPresentationController?.barButtonItem = editButtonItem
        
        present(alertController, animated: true)
    }
    
   //func
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuizResultController.shared.quizResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizResultCell", for: indexPath)
        let quizResult = QuizResultController.shared.quizResults[indexPath.row]
        cell.textLabel?.text = quizResult.name
        cell.detailTextLabel?.text = "\(quizResult.score)"
        return cell
    }
    
    
}
