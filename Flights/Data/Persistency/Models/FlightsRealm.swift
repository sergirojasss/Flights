//
//  FlightsRealm.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import RealmSwift

class FlightsRealm: Object {
    @Persisted var id: Int = -1
    @Persisted var airline: String = ""
    @Persisted var departureAirportCode: String = ""
    @Persisted var arrivalAirportCode: String = ""
    @Persisted var price: Float = 0.0
    @Persisted var isInbounds: Bool = true

    override init() {}

    init(from model: FlightEntity) {
        self.id = model.id
        self.airline = model.airline
        self.departureAirportCode = model.departureAirportCode
        self.arrivalAirportCode = model.arrivalAirportCode
        self.price = model.price
        self.isInbounds = model.type == .inbound
    }
}

extension FlightsRealm {
    func toDomain() -> FlightEntity {
        return FlightEntity(id: id,
                            airline: airline,
                            departureAirportCode: departureAirportCode,
                            arrivalAirportCode: arrivalAirportCode,
                            price: price,
                            type: isInbounds ? .inbound : .outbound)
    }
}
