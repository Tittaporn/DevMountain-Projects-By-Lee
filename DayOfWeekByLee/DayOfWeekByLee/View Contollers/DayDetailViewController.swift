//
//  DayDetailViewController.swift
//  DayOfWeekByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import UIKit

class DayDetailViewController: UIViewController {
    
    // MARK : - Outlets
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var dayOriginLabel: UILabel!
    
    // MARK : - Properites
    var day: Day?
    
    // MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
    }
    
    // MARK : - Functions
    func updateView(){
        /*
         //Mock data
         dayNameLabel.text = "This is my day"
         dayOriginLabel.text = "This is my origin description. kadsfj;lkasdjfl;ksadjlfk;js;ldajflk;asdjfl;kajsl;kfja;lskdjfkl;asdjfl;kajsdl;fkjasdl;kjfl;kadsjf;lkajsdklf"
         */
        
        guard let day = day else {return}  //using guard to make sure it is not nil. But the first `day` is newDay, it is not optional. The second `day` is the day that we get from receiving from DayListTableViewController
        dayNameLabel.text = day.name
        dayOriginLabel.text = day.origin
        
        
    }
    
    
}
