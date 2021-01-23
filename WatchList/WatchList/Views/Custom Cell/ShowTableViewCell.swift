//
//  ShowTableViewCell.swift
//  WatchList
//
//  Created by Lee McCormick on 1/14/21.
//

import UIKit

/* The 4 STEP OF PROTOCOL AND DELEGATE
 
 // STEP 1:  Create Protocol    //PROTOCOL AND DELEGATE
 // STEP 2:  Create delegate    //PROTOCOL AND DELEGATE
 // STEP 3:  Conform delegate   //PROTOCOL AND DELEGATE
 // STEP 4:  Assign delegate    //PROTOCOL AND DELEGATE
 
 */

// STEP 1:  Create Protocol //PROTOCOL AND DELEGATE
// MARK: - Protocol >> This custom protocol
protocol ShowTableViewCellDelegate: AnyObject { //class >> We can use class or AnyObject
    
    //Only the order but no detail how to do it.
    func buttonTapped(sender: ShowTableViewCell) //Doordash the sender == is DoorDash
}

class ShowTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var haveWatchButton: UIButton!
    
    // MARK: - Properties
    //Assign who to do it. Assign it to delegate
    //weak >> Is something to do with memory management.
    
    // STEP 2:  Create Delegate //PROTOCOL AND DELEGATE
    weak var delegate: ShowTableViewCellDelegate?
    
    // MARK: - Actions
    @IBAction func haveWatchButtonTapped(_ sender: Any) {
        // 
        delegate?.buttonTapped(sender: self)
    }
    
    // MARK: - Methods
    func updateWith(show: Show) {
        titleLabel.text = show.title
        //to do some stuff
        updateButtonStatusWith(haveWatched: show.haveWatched)
    }
    
    func updateButtonStatusWith(haveWatched: Bool) {
        // imageName  = .......... ?   true :  false
        let imageName = haveWatched ? "complete" : "incomplete"
        haveWatchButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
