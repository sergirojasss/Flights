//
//  Airline.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

struct AirlineEntity {
    let id, name, headline, airlineDescription: String
    let logoImg: String
    let mainImg: String
    
    func toModel() -> AirlineModel {
        return AirlineModel(id: id,
                            name: name,
                            headline: headline,
                            airlineDescription: airlineDescription,
                            logoImg: logoImg,
                            mainImg: mainImg)
    }
}

