//
//  Flight.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

// MARK: - FlightType
enum FlightType {
    case outbound
    case inbound
}

// MARK: - Flight
struct Flight {
    let id: Int
    let airline: String
    let departureAirportCode, arrivalAirportCode: String
    let price: Int
    let type: FlightType
}
