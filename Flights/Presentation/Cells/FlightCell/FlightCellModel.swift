//
//  FlightCellModel.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation

struct FlightCellModel {
    var airline: String
    var departure: String
    var arrival: String
    var price: Float
    var inbounds: String
    
    func priceAsString() -> String {
        return "\(price) €"
    }
    
    init(from model: FlightModel) {
        airline = model.airline
        departure = model.departureAirportCode
        arrival = model.arrivalAirportCode
        price = model.price
        inbounds = model.type == .inbound ? "IN" : "OUT"
    }
}
