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

struct FlightModel {
    let id: Int
    let price: Float
    let airline: String
    let departureAirportCode, arrivalAirportCode: String
    let airlineLogo: URL?
    let airlineHeadline: String?
    let type: FlightTypeModel
    
    init(from entity: FlightEntityWithLogo) {
        self.id = entity.id
        self.price = entity.price
        self.airline = entity.airline
        self.departureAirportCode = entity.departureAirportCode
        self.arrivalAirportCode = entity.arrivalAirportCode
        self.airlineLogo = entity.logo
        self.airlineHeadline = entity.airlineHeadline
        self.type = entity.type == .inbound ? .inbound : .outbound
    }
    
}

