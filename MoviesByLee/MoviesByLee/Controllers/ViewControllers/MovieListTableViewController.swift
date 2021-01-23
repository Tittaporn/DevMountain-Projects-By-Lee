//
//  MovieListTableViewController.swift
//  MoviesByLee
//
//  Created by Lee McCormick on 1/9/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MovieController.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        // Configure the cell...
        let movie = MovieController.movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.director
        
        print("The movie \(movie.title) is at index \(indexPath.row) on the movies array and therefore will be on row \(indexPath.row + 1)")
        return cell
    }
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // IIDOO
        //Identifier
        if segue.identifier == "toDetaiView" {
            
            
            //This way we are guarding 2 values at the same time to make sure we have indexPath and destinationVC, if we don't have those then guard help to exist to get out and not crash the app
            
            //Index
            guard let indexPath = tableView.indexPathForSelectedRow,
                  
                  //Destination
                  let destinationVC = segue.destination as? MovieDetailViewController
                    
            else {return}
            
            
            //Obect to Send
            let movieTosend = MovieController.movies[indexPath.row]
            
            //Object to Receive
            destinationVC.movie = movieTosend
            
        }
    }

    
    // Segue using show to show the whole screen
    // Segue using present modelly to slider ?????? Not Sure.

}
