//
//  ViewController.swift
//  ReviewAppForWeek
//
//  Created by Lee McCormick on 1/22/21.
//

import UIKit

class ConceptListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var knownConcepts = ["A", "B"]
    var unknownConcepts = ["C", "D"]
    var concepts: [[String]] {[knownConcepts, unknownConcepts]} // A computed property.
    
    var firstName = "Lee"
    var lastName = "McCormick"
    var fullName: String {
        print("I am calculating the value!")
        return firstName + " " + lastName
    } // work like a function.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
    }
}

extension ConceptListViewController: UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        print("How many sections?")
        return concepts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("How many rows in section \(section)?")
        return concepts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conceptCell", for: indexPath)
    
        print("The section is: \(indexPath.section) and the row is: \(indexPath.row)")
        let concept = concepts[0][0]
        
        let conceptForB = concepts[0]
        let bConcept = conceptForB[1]
        
        let conceptAToD = concepts[indexPath.section][indexPath.row]
        
        
        //let concept = ConceptController.shared.concepts[indexPath.section][indexPath.row]
        cell.textLabel?.text = concept  + " " + bConcept + " " + concepts[1][0] + " " + concepts[1][1]
        cell.detailTextLabel?.text = conceptAToD
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Known Concepts"
        } else if section == 1 {
            return "Not Mastered Concepts"
        } else {
            return nil
        }
    }
    
}

