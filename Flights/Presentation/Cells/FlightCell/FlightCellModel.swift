//
//  FlightCellModel.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation

struct FlightCellModel {
    var id: Int
    var airlineName: String
    var departure: String
    var arrival: String
    var price: Float
    var airlineLogo: URL?
    var airlineDesc: String?
    
    func priceAsString() -> String {
        return "\(price) €"
    }
    
    init(from model: FlightModel) {
        id = model.id
        airlineName = model.airline
        departure = model.departureAirportCode
        arrival = model.arrivalAirportCode
        price = model.price
        airlineLogo = model.airlineLogo
        airlineDesc = model.airlineDesc
    }
}
