//
//  FlightModel.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

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
        //TODO: Implement this
        return true
    }
}
