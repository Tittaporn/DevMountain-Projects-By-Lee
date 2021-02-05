//
//  YakTableViewCell.swift
//  YikyYak
//
//  Created by Lee McCormick on 2/4/21.
//

import UIKit

class YakTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var yakTextLabel: UILabel!
    @IBOutlet weak var yakScoreLabel: UILabel!
    
    
    // MARK: - Properties
    var yak: Yak? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func upVoteButtonTapped(_ sender: Any) {
        guard let yak = yak else { return }
        yak.score += 1
        YakController.shared.updateYak(yak: yak) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let yak):
                    self.yakScoreLabel.text = "\(yak.score)"
                case .failure(let error):
                    print(error.errorDescription ?? "Error updating." )
                }
            }
        }
    }
    
    @IBAction func downVoteButtonTapped(_ sender: Any) {
        guard let yak = yak else { return }
        yak.score -= 1
        YakController.shared.updateYak(yak: yak) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let yak):
                    self.yakScoreLabel.text = "\(yak.score)"
                case .failure(let error):
                    print(error.errorDescription ?? "Error updating." )
                }
            }
        }
    }
    
    // MARK: - Helper Fuctions
    func updateViews() {
        guard let yak = yak else { return }
        yakTextLabel.text = "\(yak.text)\n\n\t~\(yak.author)"
        yakScoreLabel.text = String(yak.score)
    }
}
