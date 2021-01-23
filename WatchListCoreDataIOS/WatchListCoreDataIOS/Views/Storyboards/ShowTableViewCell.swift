//
//  ShowTableViewCell.swift
//  WatchListCoreDataIOS
//
//  Created by Lee McCormick on 1/21/21.
//

import UIKit
// MARK: - Protocol
protocol ShowTableViewCellDelegate: AnyObject {
    func buttonTapped(sender: ShowTableViewCell)
}


class ShowTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var haveWatchButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: ShowTableViewCellDelegate?

    // MARK: - Actions
    @IBAction func haveWathedButtonTapped(_ sender: Any) {
        // Hey ShowTableViewCell you are about to assign delegate. ??? 
        delegate?.buttonTapped(sender: self)
    }
    
    // MARK: - Methods
    func updateWith(show: Show) {
        titleLabel.text = show.title
        updateButtonStatus(haveWatched: show.haveWatched)
    }
    
    func updateButtonStatus(haveWatched: Bool) {
        let imageName = haveWatched ? "complete" : "incomplete"
        haveWatchButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
