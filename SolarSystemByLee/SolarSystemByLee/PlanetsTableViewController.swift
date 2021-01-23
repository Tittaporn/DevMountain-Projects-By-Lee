//
//  PlanetsTableViewController.swift
//  SolarSystemByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import UIKit

class PlanetsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlanetController.planets.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // display cell once at a time depends on PlanetController.planets.count
        let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath)
        
        // Configure the cell... these cells have two labels and imageView we need to design
        cell.textLabel?.text = PlanetController.planets[indexPath.row].planetName
        cell.detailTextLabel?.text = "Planet \(indexPath.row + 1)"
        cell.imageView?.image = UIImage(named: PlanetController.planets[indexPath.row].planetImageNameInPng)
        
        //Update Style
        cell.textLabel?.textColor = .brown
        cell.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 20)!
        cell.detailTextLabel?.textColor = .brown
        cell.detailTextLabel?.font = UIFont(name: "Apple Color Emoji", size: 18)!
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //send data with that segue to the second screen(file)
        
        //Identifier
        if segue.identifier == "toDetailView" {
            
            //IndexPath
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            //Destination
            guard let destination = segue.destination as? DetailViewController else {return}
            
            //Object to send
            let planetToSend = PlanetController.planets[indexPath.row]
            
            print(planetToSend)
            
            //Object to receive
            destination.planet = planetToSend
            
        }
        
        
    }
    
    
}

/*
       // IIDOO for `override func prepare(for segue: UIStoryboardSegue, sender: Any?){}`

        I Identifer - What segue was triggered
        I Index - Find what cell was tapped on
        D Destination: Ensure the data is moving to the correct view controller
        O Object To Send : Use the `selectedIndex` to find what object to send?
        O Object To Receive : Assign that `planet` object to the landing pad we set on the `detailViewController`
        
        //This code from Karl Pfister
        
        /// Identifier : Check what segue was fired
                if segue.identifier == "toPlanetDetailVC" {
        
                    /// Index : Find what cell was tapped on
                    if let selectedIndex = tableView.indexPathForSelectedRow {
        
                        /// Destination: Ensure the data is moving to the correct view controller
                        if let detailViewController = segue.destination as? PlanetDetailViewController {
        
                            /// Object: Use the `selectedIndex` to find what object to send?
                            let planet = PlanetController.planets[selectedIndex.row]
        
                            /// Object: Assign that `planet` object to the landing pad we set on the `detailViewController`
                            detailViewController.planet = planet
                        }
                    }
                }
       */
