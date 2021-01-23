//
//  DayController.swift
//  DayOfWeekByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import Foundation

class DayController {
    
    // static var daysOfTheWeek: [] >> make it access from every where out side a class. 
    //Value Properties Always Reture Something
    
    //Source of the truth
    static var daysOfTheWeek: [Day] {
        let monday = Day(name: "Monday", origin: "Added to the roman calender by Emperor Constantine")
        let tuesday = Day(name: "Tuesday", origin: "Tuesday comes from Tiu, or Tiw, the Anglo-Saxon name for Tyr, the Norse god for war. Tyr was one of the sons of Odin.")
        let wednesday = Day(name: "Wednesday", origin: "Odin -- also known as Woden, the supreme deity after whom Wednesday is named.")
        let thursday = Day(name: "Thursday", origin: "Thursday originateds from Thor, the god of thunder.")
        let friday = Day(name: "Friday", origin: "Friday is derived from Frigga, the wife of Odin, representing love and beauty.")
        let saturday = Day(name: "Saturday", origin: "Saturday comes from Saturn, the ancient Roman god of fun and feasting.")
        let sunday = Day(name: "Sunday", origin: "Added to the roman calendar by Emperor Constantine.")
        return [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
    }
}
