//
//  ViewController.swift
//  SolarSystemByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetDiameterLabel: UILabel!
    @IBOutlet weak var planetMaximunDistanceLabel: UILabel!
    @IBOutlet weak var planetDayLength: UILabel!    
    
    // Receiver - What will receive the data from TBVC
    
    var planet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        //For gradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.darkGray.cgColor, UIColor.black.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Helper function
    func updateView(){
        guard let planet = planet else {return}
        planetNameLabel.text = planet.planetName
        imageView.image = UIImage(named: planet.planetImageName)
        planetDiameterLabel.text = String(planet.planetDiameter)
        planetMaximunDistanceLabel.text = String(planet.maxMillionKMsFromSun) + " 10^6km."
        planetDayLength.text = String(planet.planetDayLength) + " hours."
    }
    
}

