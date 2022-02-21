//
//  Flight.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

// MARK: - FlightType
enum FlightType {
    case outbound
    case inbound
}

// MARK: - Flight
struct FlightEntity {
    let id: Int
    let airline: String
    let departureAirportCode, arrivalAirportCode: String
    let price: Float
    let type: FlightType    
}

struct FlightEntityWithLogo: Transport {
    var id: Int
    let airline: String
    let departureAirportCode, arrivalAirportCode: String
    var price: Float
    let type: FlightType
    let logo: URL?
    
    init(from entity: FlightEntity, logo: URL?) {
        self.id = entity.id
        self.airline = entity.airline
        self.departureAirportCode = entity.departureAirportCode
        self.arrivalAirportCode = entity.arrivalAirportCode
        self.price = entity.price
        self.type = entity.type
        self.logo = logo
    }
    
    func isCombinableWith(transport: Transport) -> Bool {
        guard let flight = transport as? FlightEntityWithLogo else { return false }
        if airline == flight.airline
            && departureAirportCode == flight.arrivalAirportCode
            && arrivalAirportCode == flight.departureAirportCode { return true }
        return false
    }
    
    func isCombinableWith(transports: [Transport]) -> [FlightEntityWithLogo] {
        guard let flights = transports as? [FlightEntityWithLogo] else { return [] }
        let meetAirlineAndAirport = flights.filter { flightModel in
            return isCombinableWith(transport: flightModel)
        }
        if !meetAirlineAndAirport.isEmpty {
            return meetAirlineAndAirport
        }
        let meetOnlyAirports = flights.filter { flightModel in
            return departureAirportCode == flightModel.arrivalAirportCode
            && arrivalAirportCode == flightModel.departureAirportCode
        }
        return meetOnlyAirports
    }

}

