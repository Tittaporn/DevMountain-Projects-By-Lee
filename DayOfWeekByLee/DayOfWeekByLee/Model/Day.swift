//
//  Day.swift
//  DayOfWeekByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import Foundation

//Creat a model for our day

class Day {
    
    //Properly of the `Day` object that will hold the name of the day
    let name: String //= "Monday" >> NOT init dat
    //Properly of the `Day` object that will showcase the history of the days origin
    let origin: String //= "Monday"
    
/*
     WE DO NOT NEED init
     1) if we gave the value for the probatris
     2) if we do an optional for probaty
     
     Initialize(create) a `Day` object
     -Parameters:
            - dayName: String value for the Day's `name` properly
            - origin: String value for the Day's `origin` properly
     
     This memberwise initializer will set the values of `name` and `origin` properties of a created `Day` object.
     
 */
    
    init(name: String, origin: String) { //It is a init function, need to do something to get the values for the class. Crate a way for the parameter to get in
        self.name = name
        self.origin = origin
    }
    
//    func printDayAndOrigin(){
//        print("day: \(name) and description: \()")
//    }
    
    /*
 WE DO NOT NEED init 1) if we gave the value for the probatris 2) if we do an optional for probaty
 */
}



let today = Day(name: "Monday", origin: "description") //This is the init function from the class.
