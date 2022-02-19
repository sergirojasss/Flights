//
//  Airline+Decodable.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

//MARK: - AirlinesListResponse
struct AirlinesListResponse: Codable {
    let airlinesResponse: [AirlinesResponse]
    
    func toDomain() -> [Airline] {
        return airlinesResponse.map{ $0.toDomain() }
    }
}


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
    
    func toDomain() -> Airline {
        return Airline(id: id,
                       name: name,
                       headline: headline,
                       airlineDescription: airlineDescription,
                       logoImg: logoImg,
                       mainImg: mainImg)
    }
}
