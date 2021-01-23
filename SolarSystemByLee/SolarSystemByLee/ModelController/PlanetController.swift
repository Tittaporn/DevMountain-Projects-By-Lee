//
//  PlanetController.swift
//  SolarSystemByLee
//
//  Created by Lee McCormick on 1/7/21.
//

import Foundation

class PlanetController {
    
    //This is a computed probatry. It also return value type. It gives it value from computation.
    //static make it global variable and access from anywhere out side the class. The default is private.
    
    static var planets: [Planet] {
        
        let mercury = Planet(planetName: "Mercury", planetImageName: "mercury", planetDiameter: 4880, planetDayLength: 87.969, maxMillionKMsFromSun: 43.0, planetImageNameInPng: "mercury.png")
        
        let venus = Planet(planetName: "Venus", planetImageName: "venus", planetDiameter: 12104, planetDayLength: 2802, maxMillionKMsFromSun: 108.2, planetImageNameInPng: "venus.pgn")
        
        let earth = Planet(planetName: "Earth", planetImageName: "earth", planetDiameter: 12756, planetDayLength: 24, maxMillionKMsFromSun: 149.6, planetImageNameInPng: "earth.png")
        
        let mars = Planet(planetName: "Mars", planetImageName: "mars", planetDiameter: 6792, planetDayLength: 24.7, maxMillionKMsFromSun: 227.9, planetImageNameInPng: "mars.png")
        
        
        let jupiter = Planet(planetName: "Jupiter", planetImageName: "jupiter", planetDiameter: 142984, planetDayLength: 9.9, maxMillionKMsFromSun: 778.6, planetImageNameInPng: "jupiter.png")
        
        let saturn = Planet(planetName: "Saturn", planetImageName: "saturn", planetDiameter: 120536, planetDayLength: 10.7, maxMillionKMsFromSun: 1433.5, planetImageNameInPng: "saturn.png")
        
        let uranus = Planet(planetName: "Uranus", planetImageName: "uranus", planetDiameter: 51118, planetDayLength: 17.2, maxMillionKMsFromSun: 2872.5, planetImageNameInPng: "uranus.png")
        
        let neptune = Planet(planetName: "Neptune", planetImageName: "neptune", planetDiameter: 49528, planetDayLength: 16.1, maxMillionKMsFromSun: 4495.1, planetImageNameInPng: "neptune.png")
        
        let pluto = Planet(planetName: "Pluto", planetImageName: "pluto", planetDiameter: 2370, planetDayLength: 153.3, maxMillionKMsFromSun: 5906.4, planetImageNameInPng: "pluto.png")
        
        
        return [mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto]
    }
}

/*
 In this modle controller, we can write code to create, reuse, update and delete. But now, we only create!!!
 CRUD
 Create
 Reuse
 Update
 Delete
 */
