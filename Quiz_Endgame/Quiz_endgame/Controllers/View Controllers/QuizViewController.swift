//
//  QuizViewController.swift
//  Quiz_Endgame
//
//  Created by stanley phillips on 3/8/21.
//

import UIKit

class QuizViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var quizTextLabel: UILabel!
    
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    
    var currentQuestionNum = 0
    var currentScore = 0
    var questions: [Question] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        falseButton.layer.cornerRadius = 8
        trueButton.layer.cornerRadius = 8
        self.questions = QuestionController.shared.randomize()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        //if there are more questions
        if currentQuestionNum + 1 <= questions.count {
            print(currentQuestionNum)
            print(questions.count)
            if sender.titleLabel?.text == questions[currentQuestionNum].answer {
                currentScore += 1
                
                sender.backgroundColor = .systemGreen
            } else {
                sender.backgroundColor = .systemRed
            }
            
            currentQuestionNum += 1
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateViews), userInfo: nil, repeats: false)
        }
        
    }
    
    func presentQuizCompleteAlert() {
        let alertController = UIAlertController(title: "", message: "Your score is \(currentScore) out of \(questions.count). \n Enter name to save high score.", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name..."
        }
        
        let dismissAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            guard let name = alertController.textFields?.first?.text,
                  !name.isEmpty else {return}
            QuizResultController.shared.createQuizResult(name: name, score: self.currentScore)
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(dismissAction)
        alertController.popoverPresentationController?.barButtonItem = editButtonItem
        
        present(alertController, animated: true)
    }
    
    // MARK: - Functions
    @objc func updateViews() {
        if currentQuestionNum + 1 <= questions.count {
            scoreLabel.text = "Score: \(currentScore)"
            quizTextLabel.text = questions[currentQuestionNum].text
            
            trueButton.backgroundColor = .systemBlue
            falseButton.backgroundColor = .systemBlue
        } else {
            scoreLabel.text = "Score: \(currentScore)"
            trueButton.backgroundColor = .systemBlue
            falseButton.backgroundColor = .systemBlue
            
            presentQuizCompleteAlert()
        }
    }
}
