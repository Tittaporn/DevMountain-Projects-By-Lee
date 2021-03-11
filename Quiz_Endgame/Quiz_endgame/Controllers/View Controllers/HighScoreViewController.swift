//
//  HighScoreViewController.swift
//  Quiz_Endgame
//
//  Created by stanley phillips on 3/8/21.
//

import UIKit

class HighScoreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        QuizResultController.shared.fetchQuizResults()
        tableView.reloadData()
    }
}

extension HighScoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return QuizResultController.shared.quizResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        let quizResult = QuizResultController.shared.quizResults[indexPath.row]
        cell.textLabel?.text = quizResult.name
        cell.detailTextLabel?.text = "\(quizResult.score)"
        return cell
    }
}
