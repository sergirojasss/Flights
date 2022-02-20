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
    
    func priceAsString() -> String {
        return "\(price) €"
    }
    
    init(from model: FlightModel, and airline: AirlineModel?) {
        id = model.id
        airlineName = model.airline
        departure = model.departureAirportCode
        arrival = model.arrivalAirportCode
        price = model.price
        if let url = URL(string: airline?.logoImg ?? "") {
            airlineLogo = url
        }
    }
}
