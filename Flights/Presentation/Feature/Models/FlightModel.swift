//
//  FlightModel.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import Alamofire

// MARK: - FlightType
enum FlightTypeModel {
    case outbound
    case inbound
}

struct FlightModel: Transport {
    var id: Int
    var price: Float
    let airline: String
    let departureAirportCode, arrivalAirportCode: String
    let type: FlightTypeModel
    
    func isCombinableWith(transport: Transport) -> Bool {
        guard let flight = transport as? FlightModel else { return false }
        if airline == flight.airline
            && departureAirportCode == flight.arrivalAirportCode
            && arrivalAirportCode == flight.departureAirportCode { return true }
        return false
    }
    
    func isCombinableWith(transports: [Transport]) -> [FlightModel] {
        guard let flights = transports as? [FlightModel] else { return [] }
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

