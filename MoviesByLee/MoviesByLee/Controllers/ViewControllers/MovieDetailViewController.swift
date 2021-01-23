//
//  MovieDetailViewController.swift
//  MoviesByLee
//
//  Created by Lee McCormick on 1/9/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //Mark: - Outlets
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directLabel: UILabel!
    
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    //Mark: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //Mark: - Properties
    var movie: Movie?
    
    //Mark: - Fuctions
    // Guard let to ensure that there is something has a value
    func updateView() {
        guard let movieMan = movie else {return}
        titleLabel.text = movieMan.title
        directLabel.text = movieMan.director
        posterImageView.image = UIImage(named: movieMan.moviePoster)
        ratingLabel.text = "Rating: \(movieMan.rating)"
        descriptionLabel.text = movieMan.description
        releaseYearLabel.text = "Release Year : \(movieMan.releaseYear)"
        
        
    }

}

/**
 Option Click and drag ==  command D == command C and command V == to copy the lable or image on storyborad
 
 contrait >> 1) From top to bottom one by one
 2) size, horizotal , vertical
 */
