//
//  Planet.swift
//  SolarSystemByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import Foundation

class Planet {
    
    let planetName: String
    let planetImageName: String
    let planetDiameter: Int
    let planetDayLength: Double
    let maxMillionKMsFromSun: Double
    let planetImageNameInPng: String
    
    init(planetName: String, planetImageName: String, planetDiameter: Int, planetDayLength: Double, maxMillionKMsFromSun: Double, planetImageNameInPng: String) {
        self.planetName = planetName
        self.planetImageName = planetImageName
        self.planetDiameter = planetDiameter
        self.planetDayLength = planetDayLength
        self.maxMillionKMsFromSun = maxMillionKMsFromSun
        self.planetImageNameInPng = planetImageNameInPng
        
    }
}
