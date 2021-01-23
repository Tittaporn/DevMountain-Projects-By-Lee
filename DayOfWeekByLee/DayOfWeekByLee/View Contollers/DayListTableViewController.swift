//
//  DayListTableViewController.swift
//  DayOfWeekByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import UIKit

class DayListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DayController.daysOfTheWeek.count
    }
    
    /*
     1) Count the row
     2) set the cell in the storyBoard with Identifier Name you want, and copy to here
     let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
     3) setting the textLable from the `[indexPath.row]`. It is the index count.
     
     cell.textLabel?.text = DayController.daysOfTheWeek[indexPath.row].name
     */
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        
        /*
         print(indexPath)
         The first is [sectionIndexPath, rowIndexPath]
         [0, 0]
         [0, 1]
         [0, 2]
         [0, 3]
         [0, 4]
         [0, 5]
         [0, 6]
         
         print(indexPath.row)
         0
         1
         2
         3
         4
         5
         6
         
         print(indexPath.section)
         0
         0
         0
         0
         0
         0
         0
         */
        
        
        //If you hit break point here, it will run \(DayController.daysOfTheWeek.count) times
        // print(indexPath.row)
        cell.textLabel?.text = DayController.daysOfTheWeek[indexPath.row].name
        cell.detailTextLabel?.text = "Hey this is detail"
        
        
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        /*
        // IIDOO
        I = Identifier
        I = IndexPath
        D = Destination
        O = Obect to Send
        O = Obect to Receive
         */
        
        // I = Identifier
        // Set up segue in storyBoard first, then compare this identifier here
        if segue.identifier == "toDetailVC" {
            
            // I = indexPath
            // This line showing us, which indexPath user are on. and using guard to force it.
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
           
            // D = Destination
            guard let destination = segue.destination as? DayDetailViewController else {return}
            
            // O = Obect to Send >>the objects or anything you want to send from this view.
            let dayToSend = DayController.daysOfTheWeek[indexPath.row]        
            
            // O = Obect to Receive >> before write this line of code, we have to create the object in another destination or here is "DayDetailViewController"
            destination.day = dayToSend
        }
    }
}
