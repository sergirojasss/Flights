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
struct FlightEntity {
    let id: Int
    let airline: String
    let departureAirportCode, arrivalAirportCode: String
    let price: Float
    let type: FlightType
    
    func toModel() -> FlightModel {
        return FlightModel(id: id,
                           price: price,
                           airline: airline,
                           departureAirportCode: departureAirportCode,
                           arrivalAirportCode: arrivalAirportCode,
                           type: type == .inbound ? .inbound : .outbound)
    }
}
