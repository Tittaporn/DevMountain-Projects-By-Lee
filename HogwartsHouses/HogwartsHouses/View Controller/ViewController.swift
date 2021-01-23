//
//  ViewController.swift
//  HogwartsHouses
//
//  Created by Lee McCormick on 1/6/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var houseOneLabel: UILabel!
    @IBOutlet weak var houseTwoLabel: UILabel!
    @IBOutlet weak var houseThreeLabel: UILabel!
    @IBOutlet weak var houseFourLabel: UILabel!
    
    //MARK: - Properties
    let hogwartsArray = ["Slytherin","Gryffindor", "Ravenclaw", "Hufflepuff"]
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        displayHouse()
    }
    
    //MARK: - Functions
    func displayHouse(){
        
        var index = 0
        
        for house in hogwartsArray {
            if index == 0 {
                houseOneLabel.text = house
            } else if index == 1 {
                houseTwoLabel.text = house
            } else if index == 2 {
                houseThreeLabel.text = house
            } else if index == 3 {
                houseFourLabel.text = house
            } else {
                print("Can not do anything.")
            }
        index += 1
        }
        
    }
    
}
    
    /* by Lee McCormick
    let houses = ["Slytherin", "Gryffindor", "Ravenclaw", "Hufflepuff"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        houseOneLabel.text = "Dumbledore"
        houseOneLabel.backgroundColor = .yellow
        houseTwoLabel.text = "Harry Potter"
        houseTwoLabel.backgroundColor = .green
        houseThreeLabel.text = "Ron"
        houseThreeLabel.backgroundColor = .blue
        houseFourLabel.text = "Hermione"
        houseFourLabel.backgroundColor = .systemPink
        settingHouseToLabels()

        
    }
    

     func settingHouseToLabels() {
        for house in houses {
            if house == "Slytherin" {
                houseOneLabel.text = "Slytherin"
            } else if house == "Gryffindor" {
                houseTwoLabel.text = "Gryffindor"
            } else if house == "Ravenclaw" {
                houseThreeLabel.text = "Ravenclaw"
            } else if house == "Hufflepuff" {
                houseFourLabel.text = "Hufflepuff"
            } else {
                print("Can not find house.")
            }
            
        }
    
    }
     */
    

