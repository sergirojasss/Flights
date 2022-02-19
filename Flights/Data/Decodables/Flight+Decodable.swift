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
    
    func toDomain() -> [Flight] {
        var flights: [Flight] = []
        flights.append(contentsOf: outboundFlights.map { $0.toDomain(type: .outbound) })
        flights.append(contentsOf: outboundFlights.map { $0.toDomain(type: .inbound) })
        return flights
    }
}

// MARK: - Flight
struct FlightResponse: Codable {
    let id: Int
    let airline: String
    let departureAirportCode, arrivalAirportCode: String
    let price: Int
    
    func toDomain(type: FlightType) -> Flight {
        return Flight(id: id,
                      airline: airline,
                      departureAirportCode: departureAirportCode,
                      arrivalAirportCode: arrivalAirportCode,
                      price: price,
                      type: type)
    }
}
