//
//  Airline+Decodable.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation


// MARK: - AirlineResponse
struct AirlinesResponse: Codable {
    let id, name, headline, airlineDescription: String
    let logoImg: String
    let mainImg: String

    enum CodingKeys: String, CodingKey {
        case id, name, headline
        case airlineDescription = "description"
        case logoImg, mainImg
    }
    
    func toDomain() -> AirlineEntity {
        return AirlineEntity(id: id,
                       name: name,
                       headline: headline,
                       airlineDescription: airlineDescription,
                       logoImg: logoImg,
                       mainImg: mainImg)
    }
}
