//
//  Flight+Decodable.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

// MARK: - FlightList
struct FlightsListResponse: Codable {
    let outboundFlights, inboundFlights: [FlightResponse]
    
    func toDomain() -> [FlightEntity] {
        var flights: [FlightEntity] = []
        flights.append(contentsOf: inboundFlights.map { $0.toDomain(type: .inbound) })
        flights.append(contentsOf: outboundFlights.map { $0.toDomain(type: .outbound) })
        return flights
    }
}

// MARK: - Flight
struct FlightResponse: Codable {
    let id: Int
    let airline: String
    let departureAirportCode, arrivalAirportCode: String
    let price: Float
    
    func toDomain(type: FlightType) -> FlightEntity {
        return FlightEntity(id: id,
                      airline: airline,
                      departureAirportCode: departureAirportCode,
                      arrivalAirportCode: arrivalAirportCode,
                      price: price,
                      type: type)
    }
}
